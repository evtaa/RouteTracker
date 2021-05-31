//
//  MapViewController.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 25.05.2021.
//

import UIKit
import CoreLocation
import GoogleMaps

class MapViewController: UIViewController, ShowAlert {
    // MARK: Properties
    var locationManager: CLLocationManager?
    var markers = [GMSMarker]()
    var isTracker: Bool = false {
        didSet {
            if isTracker {
                navigationItem.leftBarButtonItem?.title = "ON"
            } else {
                navigationItem.leftBarButtonItem?.title = "OFF"
            }
        }
    }
    var mapView: MapView {
        get {
            return view as! MapView
        }
    }
    
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
        view = MapView ()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Configure
    private func configure() {
        configureNavigationBar()
        configureLocationManager()
    }
    private func configureNavigationBar() {
        title = "Tracker"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "OFF", style: .plain, target: self, action: #selector(leftBarButtonTouchUpInside))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Current", style: .plain, target: self, action: #selector(rightBarButtonTouchUpInside))
    }
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
    
    // MARK: Private functions
    private func removeMarkers(markers: [GMSMarker]){
        markers.forEach {$0.map = nil}
        self.markers.removeAll()
    }
    private func addMarker(mapView: GMSMapView, coordinate: CLLocationCoordinate2D){
        let marker = GMSMarker(position: coordinate)
        marker.map = mapView
        markers.append(marker)
    }
    private func viewCamera(mapView: GMSMapView, coordinate: CLLocationCoordinate2D, zoom: Float){
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: zoom)
        mapView.camera = camera
    }
    private func toggleTracker() {
        if isTracker {
            locationManager?.stopUpdatingLocation()
            isTracker = false
        } else {
            locationManager?.startUpdatingLocation()
            isTracker = true
        }
    }
    private func switchOnCurrentPosition() {
        removeMarkers(markers: markers)
        locationManager?.stopUpdatingLocation()
        isTracker = false
        locationManager?.requestLocation()
    }
    
    // MARK: Actions
    @objc private func leftBarButtonTouchUpInside () {
       toggleTracker()
    }
    @objc private func rightBarButtonTouchUpInside () {
       switchOnCurrentPosition()
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latitude = locations.last?.coordinate.latitude,
              let longitude = locations.last?.coordinate.longitude else {
            return
        }
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        viewCamera(mapView: mapView.mapView, coordinate: coordinate, zoom: 17)
        addMarker(mapView: mapView.mapView, coordinate: coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showError(forViewController: self, withMessage: "\(error)")
    }
}
