//
//  CurtainCoordinator.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 06.06.2021.
//

import Foundation

class CurtainCoordinator: BaseCoordinator {
    // MARK: Public functions
    override func start() {
        showCurtainModule()
    }
    // MARK: Private functions
    private func showCurtainModule() {
        let controller = CurtainViewController()
        setAsSecondRoot(controller)
    }
}
