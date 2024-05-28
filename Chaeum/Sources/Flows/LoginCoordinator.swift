//
//  LoginCoordinator.swift
//  Chaeum
//
//  Created by 권민재 on 5/22/24.
//

import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    
    var navigationController: UINavigationController { get set }
    func showLoginVC()
}

//class LoginCoordinator: Coordinator {
//    var parentCoordinator: (any Coordinator)?
//    
//    var children: [any Coordinator] = []
//    
//    var navigationController: UINavigationController
//    
//    func start() {
//        
//    }
//    
//  
//    
//}
