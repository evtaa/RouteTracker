//
//  ApplicationCoordinator.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 03.06.2021.
//

import Foundation
final class ApplicationCoordinator: BaseCoordinator {
    // MARK: Properties
    var realmMapService: RealmMapServiceProtocol
    var realmUserService: RealmUserServiceProtocol
    var separatorFactoryAbstract: SeparatorFactoryAbstract
    var user: User?
    
    // MARK: Init
    init(realmMapService: RealmMapServiceProtocol, realmUserService: RealmUserServiceProtocol, separatorFactoryAbstract: SeparatorFactoryAbstract) {
        self.realmMapService = realmMapService
        self.realmUserService = realmUserService
        self.separatorFactoryAbstract = separatorFactoryAbstract
    }
    
    // MARK: Public functions
    override func start() {
        if UserDefaults.standard.bool(forKey: "isLogin") {
            guard let username = UserDefaults.standard.string(forKey: "username")
            else {return}
            switch realmUserService.getUserFromLogin(login: username) {
            case .success(let user):
                toMap(user: user)
            case .failure(let error):
                debugPrint(error)
            case .none:
                return
            }
        } else {
            toAuth()
        }
    }
    
    // MARK: Private functions
    private func toMap(user: User) {
        let coordinator = MapCoordinator(realmMapService: realmMapService, user: user)
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func toAuth() {
        let coordinator = AuthCoordinator(realmUserService: realmUserService,
                                          separatorFactoryAbstract: separatorFactoryAbstract)
        coordinator.onFinishFlow = { [weak self, weak coordinator] user in
            guard let self = self else {return}
            self.user = user
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
