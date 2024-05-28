//
//  TabbarController.swift
//  Chaeum
//
//  Created by 권민재 on 5/12/24.
//

import UIKit




class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbarController()

        // Do any additional setup after loading the view.
    }
    
    
    private func setupTabbarController() {
        
        let home = UINavigationController(rootViewController: HomeViewController())
        home.title = "Home"
        let test = TestViewController()
        test.title = "title"
        self.viewControllers = [home,test]
    }

}
