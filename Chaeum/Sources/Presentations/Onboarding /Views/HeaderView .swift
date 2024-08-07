//
//  HeaderView .swift
//  Chaeum
//
//  Created by 권민재 on 6/4/24.
//
import UIKit
import SnapKit
import Then
import Lottie


class HeaderView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .subPurple
        
        
        addSubview(headerImage)
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(self).inset(80)
        }
        headerImage.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.leading.trailing.equalTo(self)
            $0.bottom.equalTo(self)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {}
    
    
    
    
    
    
    //MARK: UI
    lazy var titleLabel = UILabel().then {
        $0.text = "Welcome To Chaeum"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    lazy var headerImage = UIImageView().then {
        $0.image = UIImage(named: "first")
    }
    
    lazy var subTitleLabel = UILabel().then {
        $0.text = "Sub title Label"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
    }
    
    lazy var baseView = UIView().then {
        $0.backgroundColor = .contentColor
    }
    
}



