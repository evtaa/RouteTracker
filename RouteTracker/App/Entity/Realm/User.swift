//
//  User.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 03.06.2021.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var path: Path?
    override static func primaryKey() -> String {
            return "username"
        }
    convenience init(username: String, password: String) {
        self.init()
        self.username = username
        self.password = password
    }
}
