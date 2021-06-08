//
//  RealmService.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 28.05.2021.
//

import Foundation
import RealmSwift
import GoogleMaps
import UIKit

class RealmService {
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
}
extension RealmService: RealmMapServiceProtocol {
    // MARK: Public functions
    func savePath(username: String, routePath: GMSMutablePath) {
        guard let localRealm = localRealm,
              let user = localRealm.object(ofType: User.self, forPrimaryKey: username)
        else {return}
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
                user.path = pathRealm
                //localRealm.add(pathRealm)
            }
        }
        catch let error as NSError {
            debugPrint(error)
        }
    }
    
    func getPath (username: String) -> Path? {
        guard let localRealm = localRealm,
              let path = localRealm.object(ofType: User.self, forPrimaryKey: username)?.path
        else { return nil }
        return path
    }
    
    func deletePath (username: String) {
        guard let localRealm = localRealm,
              let path = localRealm.object(ofType: User.self, forPrimaryKey: username)?.path
        else { return }
        do{
            try localRealm.write {
                localRealm.delete(path)
            }
        }
        catch let error as NSError {
            debugPrint(error)
        }
    }
}

extension RealmService: RealmUserServiceProtocol {
    // MARK: Public functions
    func getUserFromLogin (login: String) -> Result<User, DataUserError>?  {
        guard let localRealm = localRealm else { return nil }
        guard let user = localRealm.object(ofType: User.self, forPrimaryKey: login)
        else {
            return .failure(DataUserError.noFoundUsername)
        }
        return .success(user)
    }
    
    func getUserFromLoginAndPassword (login: String, password: String) -> Result<User, DataUserError>?  {
        switch getUserFromLogin(login: login) {
        case .success(let user):
            if (user.password == password) {
                return .success(user)
            } else {
                return .failure(DataUserError.invalidPassword)
            }
        case .failure(let noFoundUsername):
            return .failure(noFoundUsername)
        case .none:
            return nil
        }
    }
    
    func registrationUser (login: String, password: String) -> Result<User, Error>? {
        guard let localRealm = localRealm else { return nil }
        switch getUserFromLogin(login: login) {
        case .success(let user):
            do {
                try localRealm.write {
                    user.password = password
                }
                return .success(user)
            }
            catch let error as NSError {
                debugPrint(error)
                return .failure(error)
            }
        case .failure( _):
            switch addUser(login: login, password: password) {
            case .success (let user):
                return .success (user)
            case .failure (let error):
                debugPrint(error)
                return .failure(error)
            case .none:
                return nil
            }
        case .none:
            return nil
        }
    }
    
    func addUser (login: String, password: String) -> Result<User, Error>? {
        guard let localRealm = localRealm else { return nil }
        let user = User(username: login, password: password)
        do{
            try localRealm.write {
                localRealm.add(user)
            }
            switch getUserFromLoginAndPassword(login: login, password: password) {
            case .success(let user):
                return .success(user)
            case .failure(let error):
                debugPrint(error)
                return .failure(error)
            case .none:
                return nil
            }
           // return .success(user)
    }
        catch let error as NSError {
            debugPrint(error)
            return .failure(error)
        }
    }
}
