//
//  jobCategoryCell.swift
//  Chaeum
//
//  Created by 권민재 on 6/27/24.
//

import UIKit
import SnapKit

class JobCategoryCell: UICollectionViewCell {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .contentColor
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 8
    }
    
    func configure(with text: String) {
        label.text = text
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
    }
}
