//
//  HomeViewModel.swift
//  Chaeum
//
//  Created by 권민재 on 5/14/24.
//
import UIKit
import ReactorKit
import RxSwift

class ScheduleReactor: Reactor {
    enum Action {
        case loadSchedules
        case addSchedule(Schedule)
        case updateSchedule(Schedule)
        case deleteSchedule(Schedule)
    }

    enum Mutation {
        case setSchedules([Schedule])
        case addSchedule(Schedule)
        case updateSchedule(Schedule)
        case deleteSchedule(Schedule)
    }

    struct State {
        var schedules: [Schedule] = []
    }

    let initialState = State()
    private let useCase: ScheduleListUseCaseable

    init(useCase: ScheduleListUseCaseable) {
        self.useCase = useCase
    }

}



//MARK: Mutation
extension ScheduleReactor {
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadSchedules:
            return useCase.schedules().map { Mutation.setSchedules($0) }
        case .addSchedule(let schedule):
            return useCase.save(schedule: schedule).map { Mutation.addSchedule(schedule) }
        case .updateSchedule(let schedule):
            return useCase.save(schedule: schedule).map { Mutation.updateSchedule(schedule) }
        case .deleteSchedule(let schedule):
            return useCase.delete(schedule: schedule).map { Mutation.deleteSchedule(schedule) }
        }
    }
    
}

//MARK: Reduce
extension ScheduleReactor {
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setSchedules(let schedules):
            newState.schedules = schedules
        case .addSchedule(let schedule):
            newState.schedules.append(schedule)
        case .updateSchedule(let schedule):
            if let index = newState.schedules.firstIndex(where: { $0.uid == schedule.uid }) {
                newState.schedules[index] = schedule
            }
        case .deleteSchedule(let schedule):
            newState.schedules.removeAll { $0.uid == schedule.uid }
        }
        return newState
    }
}

