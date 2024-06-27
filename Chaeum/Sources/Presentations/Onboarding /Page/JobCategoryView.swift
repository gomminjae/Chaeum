//
//  JobCategoryView.swift
//  Chaeum
//
//  Created by 권민재 on 6/4/24.
//
import UIKit
import SnapKit
import RxSwift
import RxCocoa 
import Then


class JobCategoryView: UIView {
    
    private let dummyData = ["기획,전략","인사,HR","회계,세무","개발,데이터","디자인","양업","금융,보험"]
    
    private let disposeBag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemPink
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self).inset(20)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.bottom.equalTo(self).inset(20)
        }
    }
    
    
    
    //MARK: UI
    
    
    
    
    lazy var titleLabel = UILabel().then {
        $0.text = "정보를 입력할게요"
        $0.textColor = .white
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
  
    
    
}
