//
//  MapViewController.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 25.05.2021.
//

import UIKit
import CoreLocation
import GoogleMaps
import RxSwift
import RxCocoa

class MapViewController: UIViewController, ShowAlert, UINavigationControllerDelegate {
    // MARK: Properties
    var onLogout: (() -> Void)?
    
    private var realmMapService: RealmMapServiceProtocol
    private let locationManager = LocationManager.instance
    private var user: User
    
    private let disposeBag = DisposeBag()
    private var markers = [GMSMarker]()
    private var route: GMSPolyline?
    private var routePath: GMSMutablePath?
    private var isTracker: Bool = false {
        didSet {
            if isTracker {
                mapView.startTrackButton.setImage(UIImage(named: "startRoute-60"), for: .normal)
                mapView.stopTrackButton.setImage(UIImage(named: "stopRouteDisabled-60"), for: .normal)
            } else {
                mapView.startTrackButton.setImage(UIImage(named: "startRouteDisabled-60"), for: .normal)
                mapView.stopTrackButton.setImage(UIImage(named: "stopRoute-60"), for: .normal)
            }
        }
    }
    private var mapView: MapView {
        get {
            return view as! MapView
        }
    }
    
    //MARK: Init
    init(realmMapService: RealmMapServiceProtocol, user: User) {
        self.realmMapService = realmMapService
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
        view = MapView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Configure
    private func configure() {
        isTracker = false
        configureNavigationBar()
        configureLocationManager()
        configureStartTrackButton()
        configureStopTrackButton()
        configureRoute()
        configureViewRoute()
    }
    private func configureNavigationBar() {
        title = "Tracker"
        let rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTouchUpInside))
        navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
        let leftBarButtonItem = UIBarButtonItem(title: "Avatar", style: .plain, target: self, action: #selector(avatarButtonTouchUpInside))
        navigationItem.setLeftBarButton(leftBarButtonItem, animated: true)
    }
    private func configureLocationManager() {
        let subscription = locationManager.location.subscribe { [weak self] event in
            guard let location = event.element,
                  let self = self else { return }
            if ((self.isTracker) == true) {
                guard let coordinate = location?.coordinate,
                      let routePath = self.routePath,
                      let route = self.route else {return}
                self.addCoordinateToRoute(coordinate: coordinate, routePath: routePath, route: route)
                debugPrint(coordinate)
                self.removeMarkers(markers: self.markers)
                self.addMarker(mapView: self.mapView.mapView, coordinate: coordinate)
                self.viewCamera(mapView: self.mapView.mapView, coordinate: coordinate, zoom: 17)
            }
        }
        subscription.disposed(by: disposeBag)
        
        locationManager.error.bind { [weak self] error in
            guard let error = error,
                  let self = self else { return }
            self.showError(forViewController: self, withError: error)
        }.disposed(by: disposeBag)
    }
    private func configureStartTrackButton() {
        mapView.startTrackButton.addTarget(self, action: #selector(startTrackButtonTouchUpInside), for: .touchUpInside)
    }
    private func configureStopTrackButton() {
        mapView.stopTrackButton.addTarget(self, action: #selector(stopTrackButtonTouchUpInside), for: .touchUpInside)
    }
    private func configureRoute() {
        route = GMSPolyline()
        routePath = GMSMutablePath()
        guard let route = route else {return}
        route.strokeColor = .blue
        route.strokeWidth = 5
        route.map = mapView.mapView
    }
    private func configureViewRoute() {
        mapView.viewRouteButton.addTarget(self, action: #selector(viewTrackButtonTouchUpInside), for: .touchUpInside)
    }
    
    // MARK: Private functions
    private func removeMarkers(markers: [GMSMarker]){
        markers.forEach {$0.map = nil}
        self.markers.removeAll()
    }
    private func addMarker(mapView: GMSMapView, coordinate: CLLocationCoordinate2D){
        let marker = GMSMarker(position: coordinate)
        let image = getSavedImage(named: "avatarImage")
        marker.icon = image
        marker.map = mapView
        markers.append(marker)
    }
    private func addCoordinateToRoute(coordinate: CLLocationCoordinate2D, routePath: GMSMutablePath, route: GMSPolyline){
        routePath.add(coordinate)
        route.path = routePath
    }
    private func viewCamera(mapView: GMSMapView, coordinate: CLLocationCoordinate2D, zoom: Float){
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: zoom)
        mapView.animate(to: camera)
    }
    private func viewCameraFromRoute () {
        guard let routePath = routePath else {return}
        var arrayCoordinatesOfRoute = [CLLocationCoordinate2D]()
        for index in 0 ..< routePath.count() {
            arrayCoordinatesOfRoute.append(routePath.coordinate(at: index))
        }
        guard let southCoordinate = arrayCoordinatesOfRoute.min(by: { $0.latitude < $1.latitude}),
              let westCoordinate = arrayCoordinatesOfRoute.max(by: { $0.longitude < $1.longitude}),
              let northCoordinate = arrayCoordinatesOfRoute.max(by: { $0.latitude < $1.latitude}),
              let eastCoordinate = arrayCoordinatesOfRoute.min (by: { $0.longitude < $1.longitude})
        else {return}
        let southWest = CLLocationCoordinate2D(latitude: southCoordinate.latitude,
                                               longitude: westCoordinate.longitude)
        let northEast = CLLocationCoordinate2D(latitude: northCoordinate.latitude,
                                               longitude: eastCoordinate.longitude)
        let bounds = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 50.0)
        mapView.mapView.moveCamera(update)
    }
    private func setRouteFromLastPathRealm(routePath: GMSMutablePath, route: GMSPolyline) {
        guard let path = realmMapService.getPath(username: user.username) else {return}
        routePath.removeAllCoordinates()
        route.path = routePath
        path.coordinates.forEach {
            let coordinate = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
            //debugPrint(coordinate)
            addCoordinateToRoute(coordinate: coordinate, routePath: routePath, route: route)
        }
    }
    private func updateLocation() {
        route?.map = nil
        configureRoute()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: Actions
    @objc private func logoutButtonTouchUpInside() {
        UserDefaults.standard.set("", forKey: "username")
        UserDefaults.standard.set(false, forKey: "isLogin")
        onLogout?()
    }
    
    @objc private func avatarButtonTouchUpInside() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else{
            return }
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func startTrackButtonTouchUpInside() {
        isTracker = true
        updateLocation()
    }
    @objc private func stopTrackButtonTouchUpInside() {
        guard let routePath = routePath else {return}
        locationManager.stopUpdatingLocation()
        isTracker = false
        realmMapService.deletePath(username: user.username)
        realmMapService.savePath(username: user.username, routePath: routePath)
    }
    @objc private func viewTrackButtonTouchUpInside() {
        guard let routePath = routePath,
              let route = route else { return}
        if (isTracker) {
            showWarning(forViewController: self, withTitleOfAlert: "Notification", andMessage: "Tracker is used. You should switch off tracker, before building route", withTitleOfFirstAction: "OK", withTitleOfSecondAction: "Cancel", handlerOfFirstAction: { [weak self] _ in
                guard let self = self else {return}
                self.stopTrackButtonTouchUpInside()
                self.removeMarkers(markers: self.markers)
                DispatchQueue.main.async {
                    self.setRouteFromLastPathRealm(routePath: routePath, route: route)
                    self.viewCameraFromRoute()
                }
            }, handlerOfSecondAction:  { _ in
                return
            })
        } else {
            self.removeMarkers(markers: self.markers)
            setRouteFromLastPathRealm(routePath: routePath, route: route)
            viewCameraFromRoute()
        }
    }
    
    // MARK: - Avatar
    func saveImage(image: UIImage) -> Bool {
        let newImage = resizeImage(image: image, targetSize: CGSize(width: 100, height: 100))
        guard let data = newImage.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("avatarImage.png")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let newImage = newImage {
            return newImage
        }
        return UIImage()
    }
}

// MARK: - UIImagePickerControllerDelegate
extension MapViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = extractImage(from: info),
           saveImage(image: image) == true
        {
            print(image)
        }
        picker.dismiss(animated: true)
    }
    
    private func extractImage(from info: [UIImagePickerController.InfoKey: Any]) -> UIImage? {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            return image
        } else {
            return nil
        }
    }
}
