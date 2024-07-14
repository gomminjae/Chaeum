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
    }
    
    func start() {
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "isUserLoggedIn") {
            showHome()
            print("Home")
        } else {
            showOnboarding()
            print("Onboarding")
        }
    }
    private func showHome() {
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController)
        homeCoordinator.parentCoordinator = self
        children.append(homeCoordinator)
        homeCoordinator.start()
        window?.rootViewController = homeNavigationController
        window?.makeKeyAndVisible()
    }
    
    private func showOnboarding() {
        let onboardingNavigationController = UINavigationController()
        let onboardingCoordinator = OnboardingCoordinator(navigationController: onboardingNavigationController)
        onboardingCoordinator.parentCoordinator = self
        children.append(onboardingCoordinator)
        onboardingCoordinator.start()
        window?.rootViewController = onboardingNavigationController
        window?.makeKeyAndVisible()
    }
}
