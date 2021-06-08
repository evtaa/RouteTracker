//
//  DataUser.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 08.05.2021.
//

import Foundation

enum DataUserError: String, Error {
    case noCorrectUsername = "You entered no correct username"
    case noCorrectPassword = "You entered no correct password"
    case noFoundUsername = "This username does not exist"
    case invalidPassword = "You entered invalid password"
}

