//
//  Coordinator.swift
//  Chaeum
//
//  Created by 권민재 on 5/13/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    var parentCoordinator: (any Coordinator)?
    var window: UIWindow?
    var children: [Coordinator] = []
    
    init(_ window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
        start()
    }
    
    func start() {
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController)
        
        let tabBarController = TabBarController(homeCoordinator: homeCoordinator)
        
        window?.rootViewController = tabBarController
    }
}
