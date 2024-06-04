//
//  OnboardingViewController.swift
//  Chaeum
//
//  Created by 권민재 on 6/3/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class OnboardingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupViews() {
        view.addSubview(scrollView)
        view.backgroundColor = .white
        scrollView.addSubview(stackView)
        setupStackView()
    }
    
    override func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }
    }
    
    override func bindRX() {
        
    }
    
    
    
    private func setupStackView() {
        stackView.addArrangedSubview(HeaderView())
        stackView.addArrangedSubview(NameView())
        stackView.addArrangedSubview(NickNameView())
        
    }
    

    //MARK: UI
    lazy var scrollView = UIScrollView().then {
        $0.backgroundColor = .red
    }
    
    lazy var stackView = UIStackView().then {
        $0.backgroundColor = .white
        $0.axis = .vertical
    }
    

}
