//
//  Coordinator.swift
//  Chaeum
//
//  Created by 권민재 on 5/13/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func finish()
}

class AppCoordinator: Coordinator {
    
    
    var childCoordinators: [any Coordinator] = []
    let window: UIWindow?
    
    
    init(_ window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
    }
    
    
    func start() {
        let tabbarController = TabbarController()
        self.window?.rootViewController = tabbarController
    }
    
    func finish() {
        
    }
    
}
