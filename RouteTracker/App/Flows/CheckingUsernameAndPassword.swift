//
//  CatchErrorProtocol.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 04.05.2021.
//

import Foundation
import UIKit

protocol CheckingUsernameAndPassword {
    
}

extension CheckingUsernameAndPassword {
    
    func checkUsernameAndPassword (username: String?, password: String?) -> Result<Bool, DataUserError>? {
        guard let countUsername = username?.count,
              countUsername > 0 else {
            return .failure(DataUserError.noCorrectUsername)
        }
        guard let countPassword = password?.count,
              countPassword > 0 else {
            return .failure(DataUserError.noCorrectPassword)
        }
        return .success(true)
    }
}
