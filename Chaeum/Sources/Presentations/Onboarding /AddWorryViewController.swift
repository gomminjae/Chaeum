//
//  AddWorryViewController.swift
//  Chaeum
//
//  Created by 권민재 on 7/9/24.
//

import UIKit
import RxSwift
import SnapKit

class AddWorryViewController: BaseViewController {
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    
    override func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(textField)
        view.addSubview(addButton)
    }
    
    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(40)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(40)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(20)
            $0.width.height.equalTo(60)
            $0.centerX.equalTo(view)
        }
        
    }
    
    override func bindRX() {
        let combinedTextFields = Observable.combineLatest(
            textField.rx.text.orEmpty,
            contentField.rx.text.orEmpty,
            sizeField.rx.text.orEmpty
        )
        let transform = combinedTextFields
            .map { title, content, size in
                (title,content,Int(size) ?? 60)
            }
        let validInput = transform
            .filter { title, content, size in
                !title.isEmpty && !content.isEmpty && size > 0
            }
    
        
        addButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    
    lazy var titleLabel = UILabel().then {
        $0.text = "새 걱정 추가"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    lazy var contentLabel = UILabel().then {
        $0.text = "내용"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    lazy var sizeLabel = UILabel().then {
        $0.text = "사이즈"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    lazy var textField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "제목을 입력하세요"
    }
    
    lazy var contentField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "내용을 입력하세요"
    }
    
    lazy var sizeField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "사이즈를 입력하세요"
    }
    
    lazy var addButton = UIButton().then {
        $0.backgroundColor = .blue
        $0.setTitle("추가", for: .normal)
        $0.layer.cornerRadius = 30
    }
    
    
    

}
