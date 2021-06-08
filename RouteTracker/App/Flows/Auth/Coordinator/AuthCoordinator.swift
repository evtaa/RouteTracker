//
//  AuthCoordinator.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 03.06.2021.
//

import Foundation
import UIKit

final class AuthCoordinator: BaseCoordinator {
    // MARK: Public properties
    var onFinishFlow: ((User) -> Void)?
    
    // MARK: Private properties
    private var rootController: NavigationControllerDarkStyle?
    private var realmUserService: RealmUserServiceProtocol?
    private var separatorFactoryAbstract: SeparatorFactoryAbstract?
    
    // MARK: Init
    init (realmUserService: RealmUserServiceProtocol,
          separatorFactoryAbstract: SeparatorFactoryAbstract) {
        self.realmUserService = realmUserService
        self.separatorFactoryAbstract = separatorFactoryAbstract
    }
    
    // MARK: Public functions
    override func start() {
        showAuthModule()
    }
    
    // MARK: Private functions
    private func showAuthModule() {
        guard let realmUserService = realmUserService
        else {return}
        let controller = AuthViewController(realmUserService: realmUserService)
        controller.onRegistration = { [weak self] in
            guard let self = self else {return}
            self.showRegistrationModule()
        }
        controller.onLogin = { [weak self] user in
            guard let self = self else {return}
            self.onFinishFlow?(user)
        }
        
        let rootController = NavigationControllerDarkStyle(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }
    
    private func showRegistrationModule() {
        guard let realmUserService = realmUserService,
              let separatorFactoryAbstract = separatorFactoryAbstract,
              let rootController = rootController
        else {return}
        let controller = RegistrationViewController(realmUserService: realmUserService,
                                                    separatorFactoryAbstract: separatorFactoryAbstract)
        controller.onMap = { [weak self] user in
            guard let self = self else {return}
            self.onFinishFlow?(user)
        }
        rootController.pushViewController(controller, animated: true)
    }
}
