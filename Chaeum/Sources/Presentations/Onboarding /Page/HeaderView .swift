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
        self.backgroundColor = .clear
        
        
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(self).inset(80)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {}
    
    
    
    //MARK: UI
    lazy var titleLabel = UILabel().then {
        $0.text = "Welcome To Chaeum"
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    lazy var headerImage = UIImageView()
}



