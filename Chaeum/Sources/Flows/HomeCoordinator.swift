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
    
    private let navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVC = HomeViewController()
        navigationController.pushViewController(homeVC, animated: true)
    }
}
