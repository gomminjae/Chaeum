//
//  HomeViewModel.swift
//  Chaeum
//
//  Created by 권민재 on 5/14/24.
//
import Foundation
import RxSwift
import RxCocoa



class HomeViewModel: ViewModelType {
    
    private weak var coordinator: HomeCoordinator?
    private let disposeBag = DisposeBag()
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    
    
    init(coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
    }
    
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
