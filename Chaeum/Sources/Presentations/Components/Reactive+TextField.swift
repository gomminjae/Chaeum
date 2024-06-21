//
//  Reactive+TextField.swift
//  Chaeum
//
//  Created by 권민재 on 6/21/24.
//

import UIKit
import RxSwift
import RxCocoa


extension Reactive where Base: FloatingTextField {
    var text: ControlProperty<String?> {
        return base.rx.controlProperty(
            editingEvents: [.allEditingEvents, .valueChanged],
            getter: { textField in
                textField.text
            },
            setter: { textField, value in
                textField.text = value
            }
        )
    }

    var didBeginEditing: ControlEvent<Void> {
        return controlEvent(.editingDidBegin)
    }

    var didEndEditing: ControlEvent<Void> {
        return controlEvent(.editingDidEnd)
    }

    var didChange: ControlEvent<Void> {
        return controlEvent(.editingChanged)
    }
    
    var shouldChangeCharacters: Observable<(range: NSRange, string: String)> {
        let delegate = RxTextFieldDelegateProxy.proxy(for: base)
        return delegate.shouldChangeCharactersSubject
            .map { range, string in (range: range, string: string) }
            .asObservable()
    }
    
    var rightViewTap: Observable<Void> {
        return base.btnRightView.rx.tap.asObservable()
    }
    
    var leftViewTap: Observable<Void> {
        return base.btnLeftView.rx.tap.asObservable()
    }
}

class RxTextFieldDelegateProxy: DelegateProxy<FloatingTextField, UITextFieldDelegate>, DelegateProxyType, UITextFieldDelegate {
    
    init(textField: FloatingTextField) {
        super.init(parentObject: textField, delegateProxy: RxTextFieldDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register { RxTextFieldDelegateProxy(textField: $0) }
    }
    
    static func currentDelegate(for object: FloatingTextField) -> UITextFieldDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: UITextFieldDelegate?, to object: FloatingTextField) {
        object.delegate = delegate
    }
    
    internal lazy var shouldChangeCharactersSubject = PublishSubject<(NSRange, String)>()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let shouldChange = (self._forwardToDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string)) ?? true
        if shouldChange {
            shouldChangeCharactersSubject.onNext((range, string))
        }
        return shouldChange
    }
}
