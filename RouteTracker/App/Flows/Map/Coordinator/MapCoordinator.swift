//
//  MapCoordinator.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 03.06.2021.
//

import Foundation
import UIKit

final class MapCoordinator: BaseCoordinator {
    // MARK: Public properties
    var onFinishFlow: (() -> Void)?
    
    // MARK: Private properties
    private var rootController: NavigationControllerDarkStyle?
    private var realmMapService: RealmMapServiceProtocol?
    private var user: User?
    
    // MARK: Init
    init (realmMapService: RealmMapServiceProtocol, user: User) {
        self.user = user
        self.realmMapService = realmMapService
    }
    
    // MARK: Public functions
    override func start() {
        showMapModule()
    }
    
    // MARK: Private functions
    private func showMapModule() {
        guard let realmMapService = realmMapService,
              let user = user
        else {return}
        let controller = MapViewController(realmMapService: realmMapService, user: user)
        controller.onLogout = {[weak self] in
            self?.onFinishFlow?()}
        let rootController = NavigationControllerDarkStyle(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }
}
