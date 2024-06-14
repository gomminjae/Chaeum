//
//  CHButton.swift
//  Chaeum
//
//  Created by 권민재 on 5/28/24.
//
import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa




class CHTextField: UITextField {
    
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField(_ placeHolder: String) {
        textColor = .white
        
    }
}
