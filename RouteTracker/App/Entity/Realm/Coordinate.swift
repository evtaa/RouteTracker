//
//  Coordinate.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 28.05.2021.
//

import Foundation
import RealmSwift

class Coordinate: Object {
    @objc dynamic var _id: ObjectId = ObjectId.generate()
    @objc dynamic var ownerObjectId: ObjectId = ObjectId()
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    override static func primaryKey() -> String? {
            return "_id"
        }
    convenience init(ownerObjectId: ObjectId, latitude: Double, longitude: Double) {
        self.init()
        self.ownerObjectId = ownerObjectId
        self.latitude = latitude
        self.longitude = longitude
    }
}
