//
//  OnboardingReactor.swift
//  Chaeum
//
//  Created by 권민재 on 6/3/24.
//

import Foundation
import RxSwift
import ReactorKit


class OnboardingReactor: Reactor {
    enum Action {
        case setName(String)
        case setNickname(String)
        case setJobCategory([String])
        case setBirthdate(Date)
        case setGoal(String)
        case save
    }
    
    enum Mutation {
        case setName(String)
        case setNickname(String)
        case setJobCategory([String])
        case setBirthdate(Date)
        case setGoal(String)
        case setSaved(Bool)
    }
    
    struct State {
        var name: String = User().name
        var nickname: String = User().nickname
        var jobCategory: [String] = User().jobCategory
        var birthdate: Date = User().birthdate
        var goal: String = User().goal
        var isSaved: Bool = false
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .setName(name):
            return Observable.just(.setName(name))
        case let .setNickname(nickname):
            return Observable.just(.setNickname(nickname))
        case let .setJobCategory(jobCategory):
            return Observable.just(.setJobCategory(jobCategory))
        case let .setBirthdate(birthdate):
            return Observable.just(.setBirthdate(birthdate))
        case let .setGoal(goal):
            return Observable.just(.setGoal(goal))
        case .save:
            var user = User()
            user.name = currentState.name
            user.nickname = currentState.nickname
            user.jobCategory = currentState.jobCategory
            user.birthdate = currentState.birthdate
            user.goal = currentState.goal
            return Observable.just(.setSaved(true))
            
        }
        
        func reduce(state: State, mutation: Mutation) -> State {
            var newState = state
            switch mutation {
            case let .setName(name):
                newState.name = name
            case let .setNickname(nickname):
                newState.nickname = nickname
            case let .setJobCategory(jobCategory):
                newState.jobCategory = jobCategory
            case let .setBirthdate(birthdate):
                newState.birthdate = birthdate
            case let .setGoal(goal):
                newState.goal = goal
            case let .setSaved(isSaved):
                newState.isSaved = isSaved
            }
            return newState
        }
    }
}
