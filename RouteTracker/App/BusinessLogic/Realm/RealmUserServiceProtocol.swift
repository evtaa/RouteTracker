//
//  RealmUserProtocol.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 03.06.2021.
//

import Foundation


protocol RealmUserServiceProtocol {
    func getUserFromLogin (login: String) -> Result<User, DataUserError>?
    func getUserFromLoginAndPassword (login: String, password: String) -> Result<User, DataUserError>?
    func registrationUser (login: String, password: String) -> Result<User, Error>?
    func addUser (login: String, password: String) -> Result<User, Error>?
}
