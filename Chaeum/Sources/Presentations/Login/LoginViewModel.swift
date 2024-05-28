//
//  LoginViewModel.swift
//  Chaeum
//
//  Created by 권민재 on 5/13/24.
//

import UIKit
import RxSwift
import RxCocoa

enum SocialLoginType {
    case kakao
    case apple
}


protocol LoginViewModelBindable {
    func kakaoLogin()
    func appleLogin()
}
