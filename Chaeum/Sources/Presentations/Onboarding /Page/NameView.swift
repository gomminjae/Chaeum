//
//  NameView.swift
//  Chaeum
//
//  Created by 권민재 on 6/4/24.
//
import UIKit
import SnapKit
import Then


class NameView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        addSubview(titleLabel)
        addSubview(textField)
        
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(self).inset(40)
            $0.top.equalTo(self).inset(40)
        }
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(titleLabel.snp.leading)

        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {}
    
    
    
    //MARK: UI
    lazy var titleLabel = UILabel().then {
        $0.text = "이름을 입력해주세요."
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        $0.textColor = .white
    }
    lazy var textField = UITextField().then {
        $0.placeholder = "이름"
    }
    
    
}
