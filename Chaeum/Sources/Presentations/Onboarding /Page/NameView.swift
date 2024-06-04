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
        self.backgroundColor = .blue
        self.snp.makeConstraints {
            $0.height.equalTo(800)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {}
    
    
    
    //MARK: UI
    lazy var titleLabel = UILabel().then {
        $0.text = "정보를 입력할게요"
        $0.textColor = .white
    }
    lazy var headerImage = UIImageView().then {
        $0.backgroundColor = .red
    }
    
    
}
