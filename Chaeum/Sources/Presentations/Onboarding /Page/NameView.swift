//
//  NameView.swift
//  Chaeum
//
//  Created by 권민재 on 6/4/24.
//
import UIKit
import SnapKit
import Then
import TextFieldEffects


class NameView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(nickNameField)
        addSubview(birthDateField)
        
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(self).inset(40)
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(50)
        }
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.height.equalTo(40)
            $0.width.equalTo(250)

        }
        nickNameField.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(20)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.height.equalTo(40)
            $0.width.equalTo(250)

        }
        birthDateField.snp.makeConstraints {
            $0.top.equalTo(nickNameField.snp.bottom).offset(20)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.height.equalTo(40)
            $0.width.equalTo(250)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {}
    
    private func setupDatePicker() {
        
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .date
        
        datePicker.preferredDatePickerStyle = .wheels
        
        datePicker.locale = Locale(identifier: "ko-KR")
       
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
       
        textField.inputView = datePicker
        
        textField.text = dateFormat(date: Date())
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        // 값이 변하면 UIDatePicker에서 날자를 받아와 형식을 변형해서 textField에 넣어줍니다.
        textField.text = dateFormat(date: sender.date)
    }

    // 텍스트 필드에 들어갈 텍스트를 DateFormatter 변환
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        
        return formatter.string(from: date)
    }
    
    
    //MARK: UI
    lazy var titleLabel = UILabel().then {
        $0.text = "정보를 입력해주세요."
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        $0.textColor = .white
    }
    lazy var textField = HoshiTextField().then {
        $0.placeholderColor = .lightGray
        $0.placeholder = "이름을 입력하세요"
        $0.textColor = .white
        $0.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.15, alpha: 1.00)
        $0.borderActiveColor = .mainPurple
        $0.borderInactiveColor = .mainPurple
        
    }
    lazy var nickNameField = HoshiTextField().then {
        $0.placeholderColor = .lightGray
        $0.placeholder = "닉네임을 입력하세요"
        $0.textColor = .white
        $0.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.15, alpha: 1.00)
        $0.borderActiveColor = .mainPurple
        $0.borderInactiveColor = .mainPurple
    }
    lazy var birthDateField = HoshiTextField().then {
        $0.placeholder = "생년월일을 입력하세요"
        $0.placeholderColor = .lightGray
        $0.textColor = .white
        $0.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.15, alpha: 1.00)
        $0.borderActiveColor = .mainPurple
        $0.borderInactiveColor = .mainPurple
    }
    
    
    
}
