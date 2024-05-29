//
//  HomeViewController.swift
//  Chaeum
//
//  Created by 권민재 on 5/8/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

class HomeViewController: BaseViewController {
    
    private let disposeBag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
    }
    
    override func setupViews() {
        view.addSubview(collectionView)
    }
    
    override func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func bindRX() {
        
    }

    //MARK UI
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        $0.backgroundColor = .red
    }
    
    


}
