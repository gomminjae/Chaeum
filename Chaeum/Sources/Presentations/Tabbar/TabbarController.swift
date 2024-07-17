//
//  TabbarController.swift
//  Chaeum
//
//  Created by 권민재 on 5/12/24.
//

import UIKit
import RxSwift
import SnapKit

class TabBarController: UITabBarController {

    private let homeCoordinator: HomeCoordinator

    init(homeCoordinator: HomeCoordinator) {
        self.homeCoordinator = homeCoordinator
        super.init(nibName: nil, bundle: nil)
        setupTabbarController()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func setupTabbarController() {
        homeCoordinator.start()
        
        let homeNavigationController = homeCoordinator.navigationController
        homeNavigationController.title = "Home"

        let testViewController = TestViewController()
        testViewController.title = "Test"
        
        let settingViewController = SettingViewController()
        settingViewController.title = "Setting"

        self.viewControllers = [homeNavigationController, testViewController, settingViewController]
    }
}
