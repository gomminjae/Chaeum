//
//  ScheduleUseCase .swift
//  Chaeum
//
//  Created by 권민재 on 5/28/24.
//

import Foundation
import RxSwift

protocol ScheduleListUseCase {
    func schedules() -> Observable<[Schedule]>
    func save(schedule: Schedule) -> Observable<Void>
    func update(schedule: Schedule) -> Observable<Void>
    func delete(schedule: Schedule) -> Observable<Void>
}

class ScheduleListUseCaseImpl: ScheduleListUseCase {
    
    private let repository: ScheduleRepository
    
    init(repository: ScheduleRepository) {
        self.repository = repository
    }
    
    func schedules() -> Observable<[Schedule]> {
        return repository.fetchScheduleList()
    }
    
    func save(schedule: Schedule) -> Observable<Void> {
        return repository.saveSchedule(schedule)
    }
    func update(schedule: Schedule) -> Observable<Void> {
        return repository.updateSchedule(schedule)
    }
    func delete(schedule: Schedule) -> Observable<Void> {
        return repository.deleteSchedule(schedule)
    }
    
}

