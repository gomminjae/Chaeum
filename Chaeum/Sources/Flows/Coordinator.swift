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
    var children: [any Coordinator] = []
    //var navigationController: UINavigationController

    let window: UIWindow?
    
    
    init(_ window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
        start()
    }
    
    deinit {
        print("App Coordinator deinit")
    }
    
    func start() {
        let tabbarController = TabbarController()
        self.window?.rootViewController = tabbarController
    }
}
