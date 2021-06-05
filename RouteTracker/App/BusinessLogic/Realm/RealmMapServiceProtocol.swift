//
//  RealmServiceProtocol.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 30.05.2021.
//

import Foundation
import GoogleMaps
import RealmSwift

protocol RealmMapServiceProtocol {
    func savePath(username: String, routePath: GMSMutablePath)
    func getPath (username: String) -> Path?
    func deletePath (username: String)
}
