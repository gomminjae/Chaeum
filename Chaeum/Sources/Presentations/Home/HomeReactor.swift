//
//  HomeReactor.swift
//  Chaeum
//
//  Created by 권민재 on 6/2/24.
//

import Foundation
import ReactorKit
import RxSwift


class HomeReactor: Reactor {
    
    private let scheduleReactor: ScheduleReactor
    
    
    let initialState: State
    
    enum Action {
        case scheduleAction(ScheduleReactor.Action)
    }
    
    enum Mutation {
        case scheduleMutation(ScheduleReactor.Mutation)
    }
    
    struct State {
        var scheduleState: ScheduleReactor.State
    }
    
    
    
    init(scheduleReactor: ScheduleReactor) {
        self.scheduleReactor = scheduleReactor
        
        
        self.initialState = State(
            scheduleState: scheduleReactor.initialState
        )
    }
    
}
