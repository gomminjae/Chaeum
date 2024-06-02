//
//  ScheduleRepository.swift
//  Chaeum
//
//  Created by 권민재 on 6/2/24.
//

import Foundation
import RxSwift
import RealmSwift

protocol ScheduleRepository {
    func fetchScheduleList() -> Observable<[Schedule]>
    func saveSchedule(_ schedule: Schedule) -> Observable<Void>
    func updateSchedule(_ schedule: Schedule) -> Observable<Void>
    func deleteSchedule(_ schedule: Schedule) -> Observable<Void>
}


