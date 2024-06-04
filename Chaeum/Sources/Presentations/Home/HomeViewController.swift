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
import ReactorKit
import FSCalendar



class HomeViewController: BaseViewController {
    
    private let disposeBag = DisposeBag()
    private var reactor: HomeReactor
    
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
    
    init(reactor: HomeReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bindRX() {
        
    }
    
 

    //MARK UI
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        $0.backgroundColor = .white
    }

}
