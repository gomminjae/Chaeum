//
//  DependencyContainer.swift
//  Chaeum
//
//  Created by 권민재 on 6/3/24.
//

import Foundation

class DependencyContainer {
    static let shared = DependencyContainer()
    
    private init() {}
    
    
    lazy var scheduleRepository: ScheduleRepository = {
        return DefaultScheduleRepository()
    }()
    
    lazy var scheduleUseCase: ScheduleListUseCaseImpl = {
        return ScheduleListUseCaseImpl(repository: scheduleRepository)
    }()
    
    lazy var scheduleReactor: ScheduleReactor = {
        return ScheduleReactor(useCase: scheduleUseCase)
    }()
    

    lazy var homeReactor: HomeReactor = {
        return HomeReactor(scheduleReactor: scheduleReactor)
    }()
}
