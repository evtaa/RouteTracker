//
//  RealmServiceProtocol.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 30.05.2021.
//

import Foundation
import GoogleMaps
import RealmSwift

protocol RealmServiceProtocol {
    func addPath(routePath: GMSMutablePath)
    func getPathes () -> Results<Path>?
    func deletePathes ()
}
