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
        case selectItem(IndexPath)
        case deselectItem(IndexPath)
        case fetchCategories
    }

    enum Mutation {
        case updateCategories([String])
        case updateSelectedItems(Set<IndexPath>)
    }

    struct State {
        var categories: [String]
        var selectedItems: Set<IndexPath>
    }

    let initialState: State
    private let repository: JobCategoryRepository

    init(repository: JobCategoryRepository) {
        self.repository = repository
        self.initialState = State(categories: [], selectedItems: [])
        self.action.onNext(.fetchCategories)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchCategories:
            return repository.fetchCategories()
                .map { Mutation.updateCategories($0) }
        case let .selectItem(indexPath):
            var selectedItems = currentState.selectedItems
            selectedItems.insert(indexPath)
            return Observable.just(.updateSelectedItems(selectedItems))
        case let .deselectItem(indexPath):
            var selectedItems = currentState.selectedItems
            selectedItems.remove(indexPath)
            return Observable.just(.updateSelectedItems(selectedItems))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .updateCategories(categories):
            newState.categories = categories
        case let .updateSelectedItems(selectedItems):
            newState.selectedItems = selectedItems
        }
        return newState
    }
}
