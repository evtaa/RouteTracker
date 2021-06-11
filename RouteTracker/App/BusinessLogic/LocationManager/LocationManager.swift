//
//  LocationManager.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 10.06.2021.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

final class LocationManager: NSObject {
    static let instance = LocationManager()
    
    private override init() {
        super.init()
        configureLocationManager()
    }
    
    let locationManager = CLLocationManager()
    let location: BehaviorRelay<CLLocation?> = BehaviorRelay(value: nil)
    let error: BehaviorRelay<Error?> = BehaviorRelay(value: nil)
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.requestAlwaysAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location.accept(locations.last)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.error.accept(error)
        debugPrint(error)
    }
}
