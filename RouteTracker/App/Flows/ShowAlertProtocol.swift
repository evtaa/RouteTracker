//
//  ShowAlertProtocol.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 04.05.2021.
//

import Foundation
import UIKit

protocol ShowAlert {
    
}
extension ShowAlert {
    func showAlert (forViewController controller: UIViewController ,
                      withTitleOfAlert tittleOfAlert: String,
                      andMessage message: String,
                      withTitleOfAction tittleOfAction: String,
                      handlerOfAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: tittleOfAlert, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: tittleOfAction, style: .cancel,handler: handlerOfAction)
        alert.addAction(actionOk)
        controller.present(alert, animated: true, completion: nil)
    }
    
    func showError (forViewController controller: UIViewController, withMessage message: String) {
        self.showAlert(forViewController: controller, withTitleOfAlert: "Error", andMessage: message, withTitleOfAction: "OK", handlerOfAction: nil)
    }
}
