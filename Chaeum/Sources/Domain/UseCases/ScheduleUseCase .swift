//
//  ScheduleUseCase .swift
//  Chaeum
//
//  Created by 권민재 on 5/28/24.
//

import Foundation
import RxSwift

protocol ScheduleUseCase {
    func schedules() -> Observable<[Schedule]>
    func save(schedule: Schedule) -> Observable<Void>
}
