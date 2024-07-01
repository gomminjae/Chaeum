//
//  WorryCategoryView .swift
//  Chaeum
//
//  Created by 권민재 on 6/4/24.
//
import UIKit
import SnapKit
import Then


class WorryCategoryView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupView()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        addSubview(titleLabel)
        addSubview(addButton)
        addSubview(worryBox)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(40)
        }
        
        worryBox.snp.makeConstraints {
            $0.left.right.equalTo(self).inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(self).inset(20)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(worryBox.snp.bottom)
            $0.width.height.equalTo(60)
            $0.centerX.equalTo(self)
        }
    }
    
    
    
    //MARK: UI
    lazy var titleLabel = UILabel().then {
        $0.text = "당신은 어떤 걱정을 하고 있나요?"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .white
    }
    lazy var headerImage = UIImageView().then {
        $0.backgroundColor = .red
    }
    lazy var addButton = UIButton().then {
        $0.backgroundColor = .subPurple
        $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
    }
    lazy var worryBox = UIView().then {
        $0.backgroundColor = .contentColor
        $0.layer.cornerRadius = 15
    }
    
    
}
