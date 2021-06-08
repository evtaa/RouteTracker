//
//  Path.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 28.05.2021.
//

import Foundation
import RealmSwift

class Path: Object {
    @objc dynamic var _id: ObjectId = ObjectId.generate()
    var coordinates = RealmSwift.List<Coordinate>()
    override static func primaryKey() -> String? {
            return "_id"
        }
    convenience init(coordinates: Array<Coordinate>) {
        self.init()
        //self.coordinates = coordinates
    }
}
