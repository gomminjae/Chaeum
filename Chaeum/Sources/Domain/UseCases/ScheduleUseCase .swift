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
    func delete(schedule: Schedule) -> Observable<Void>
}


final class DefaultScheduleListUseCase {
   
}
