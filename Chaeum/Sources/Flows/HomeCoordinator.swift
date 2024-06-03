//
//  HomeCoordinator.swift
//  Chaeum
//
//  Created by 권민재 on 5/28/24.
//

import UIKit


class HomeCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let reactor = DependencyContainer.shared.homeReactor
        let homeVC = HomeViewController(reactor: reactor)
        homeVC.title = "Chaeum"
        navigationController.pushViewController(homeVC, animated: false)
    }
}
