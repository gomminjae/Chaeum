//
//  OnboardingCoordinator.swift
//  Chaeum
//
//  Created by 권민재 on 6/3/24.
//

import UIKit


class OnboardingCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    var children: [any Coordinator] = []
    
    func start() {
        let onboarding = OnboardingViewController()
        onboarding.coordinator = self
        navigationController.pushViewController(onboarding, animated: false)
    }
    
    func presentWorry() {
        let addWorry = AddWorryViewController()
        navigationController.pushViewController(addWorry, animated: true)
    }
    
    
}
