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
