//
//  CompleteView.swift
//  Chaeum
//
//  Created by 권민재 on 7/16/24.
//

import UIKit
import Then
import SnapKit

class CompleteView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(completeButton)
        
        
        
        
        completeButton.snp.makeConstraints {
            $0.width.equalTo(self.frame.width - 60)
            $0.leading.equalTo(self).inset(30)
            $0.trailing.equalTo(self).inset(30)
            $0.height.equalTo(70)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var titleLabel = UILabel().then {
        $0.text = "Complete"
    }
    
    lazy var completeButton = UIButton().then {
        $0.backgroundColor = .mainPink
    }
}
