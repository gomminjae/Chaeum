//
//  JobCategoryReactor.swift
//  Chaeum
//
//  Created by 권민재 on 6/27/24.
//

import Foundation
import RxSwift
import ReactorKit


class JobCategoryReactor: Reactor {
    
    enum Action {
        case selectedItems([IndexPath])
    }
    
    enum Mutation {
        case setSelectedItems([IndexPath])
    }
    
    struct State {
        var categories: [String]
        var selectedItems: [IndexPath]?
    }
    
    let initialState: State
    
    
    init(data: [String]) {
        self.initialState = State(categories: data)
    }

}

extension JobCategoryReactor {
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .selectedItems(let indexPath):
            return Observable.just(Mutation.setSelectedItems(indexPath))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setSelectedItems(let indexPath):
            newState.selectedItems = indexPath
        }
        
        return newState
    }
}
