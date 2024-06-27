//
//  BaseViewController.swift
//  Chaeum
//
//  Created by 권민재 on 5/28/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.09, green: 0.09, blue: 0.12, alpha: 1.00)
        setupViews()
    

        setupConstraints()
        bindRX()

        // Do any additional setup after loading the view.
    }
    
    //layout
    func setupConstraints() {}
    
    //add view
    func setupViews() {}
    
    //bind RX
    func bindRX() {}
    

}

