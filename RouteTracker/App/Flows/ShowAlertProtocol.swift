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
    func showWarning (forViewController controller: UIViewController ,
                      withTitleOfAlert tittleOfAlert: String,
                      andMessage message: String,
                      withTitleOfFirstAction tittleOfFirstAction: String,
                      withTitleOfSecondAction tittleOfSecondAction: String,
                      handlerOfFirstAction: ((UIAlertAction) -> Void)?,
                      handlerOfSecondAction: ((UIAlertAction) -> Void)?
                      ) {
        let alert = UIAlertController(title: tittleOfAlert, message: message, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: tittleOfFirstAction, style: .default ,handler: handlerOfFirstAction)
        let secondAction = UIAlertAction(title: tittleOfSecondAction, style: .cancel,handler: handlerOfSecondAction)
        alert.addAction(secondAction)
        alert.addAction(firstAction)
        controller.present(alert, animated: true, completion: nil)
    }
    
    func showAlert (forViewController controller: UIViewController ,
                      withTitleOfAlert tittleOfAlert: String,
                      andMessage message: String,
                      withTitleOfAction tittleOfAction: String,
                      handlerOfAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: tittleOfAlert, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: tittleOfAction, style: .cancel,handler: handlerOfAction)
        alert.addAction(action)
        controller.present(alert, animated: true, completion: nil)
    }
    
    func showError (forViewController controller: UIViewController, withMessage message: String) {
        self.showAlert(forViewController: controller, withTitleOfAlert: "Error", andMessage: message, withTitleOfAction: "OK", handlerOfAction: nil)
    }
    func showError (forViewController controller: UIViewController, withError error: Error) {
        self.showAlert(forViewController: controller, withTitleOfAlert: "Error", andMessage: "\(error)", withTitleOfAction: "OK", handlerOfAction: nil)
    }
}
