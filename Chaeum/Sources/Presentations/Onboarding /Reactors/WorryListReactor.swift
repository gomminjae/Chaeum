//
//  WorryListReactor.swift
//  Chaeum
//
//  Created by 권민재 on 7/2/24.
//

import Foundation
import RxSwift
import ReactorKit

class WorryListReactor: Reactor {
    
    enum Action {
        case fetchWorries
        case addWorry(title: String, content: String, size: Int)
        case deleteWorry(index: Int)
        
    }
    
    enum Mutation {
        case setWorries([Worry])
        case addWorry(Worry)
        case deleteWorry(Int)
    }
    
    struct State {
        var worries: [Worry] = []
    }
    
    let initialState: State = State()
    private let worryUseCase: WorryUseCase
    
    init(usecase: WorryUseCase) {
        self.worryUseCase = usecase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchWorries:
            return worryUseCase.fetchAllWorries()
                .map { .setWorries($0) }
        case let .addWorry(title, content, size):
            return worryUseCase.saveWorry(title: title, content: content, size: size)
                .flatMap { self.worryUseCase.fetchAllWorries() }
                .map { .setWorries($0) }
            
        case .deleteWorry(index: let index):
            let worry = currentState.worries[index]
            return worryUseCase.deleteWorry(worry: worry)
                .flatMap{ self.worryUseCase.fetchAllWorries() }
                .map {.setWorries($0)}
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setWorries(worries):
            newState.worries = worries
            
        case let .addWorry(worry):
            newState.worries.append(worry)
            
        case let .deleteWorry(index):
            newState.worries.remove(at: index)
        }
        return newState
    }
    
    
    
    
    
}

