//
//  RealmService.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 28.05.2021.
//

import Foundation
import RealmSwift
import GoogleMaps

class RealmService: RealmServiceProtocol {
    // MARK: Properties
    let localRealm: Realm?
    
    // MARK: Init
    init() {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        do {
            localRealm = try Realm(configuration: config)
        } catch let error as NSError {
            localRealm = nil
            debugPrint(error)
        }
    }
    
    // MARK: Public functions
    func addPath(routePath: GMSMutablePath) {
        guard let localRealm = localRealm else {return}
        let coordinatesOfLastPath = List<Coordinate> ()
        let pathRealm = Path()
        for index in 0 ..< routePath.count() {
            let coordinate = routePath.coordinate(at: index)
            let coordinateRealm = Coordinate(ownerObjectId: pathRealm._id,
                                             latitude: Double (coordinate.latitude),
                                             longitude: Double (coordinate.longitude))
            coordinatesOfLastPath.append(coordinateRealm)
            debugPrint(coordinate)
        }
        pathRealm.coordinates = coordinatesOfLastPath
        do{
            try localRealm.write {
                localRealm.add(pathRealm)
            }
        }
        catch let error as NSError {
            debugPrint(error)
        }
    }
    
    func getPathes () -> Results<Path>? {
        guard let localRealm = localRealm else {
            return nil }
        let pathes = localRealm.objects(Path.self)
        return pathes
    }
    
    func deletePathes () {
        guard let localRealm = localRealm else {return}
        let pathes = localRealm.objects(Path.self)
        do{
            try localRealm.write {
                localRealm.delete(pathes)
            }
        }
        catch let error as NSError {
            debugPrint(error)
        }
    }
}
