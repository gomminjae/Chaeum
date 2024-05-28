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
        
    }
    
    override func bindRX() {
        
    }

    //MARK UI
    lazy var collectionView = UICollectionView().then {
        let layout = UICollectionViewLayout()
        $0.collectionViewLayout = layout
        $0.backgroundColor = .red
    }
    
    


}
