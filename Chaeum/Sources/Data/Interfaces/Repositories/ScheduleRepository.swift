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

class DefaultScheduleRepository: ScheduleRepository {
    
    private var schedules: [Schedule] = []

    init() {
        // 초기 예제 데이터
        schedules = [
            Schedule(uid: "1", title: "Meeting", content: "Project meeting at 10 AM", priority: .high, createDate: Date()),
            Schedule(uid: "2", title: "Lunch", content: "Lunch with team at 12 PM", priority: .medium, createDate: Date()),
            Schedule(uid: "3", title: "Gym", content: "Workout session at 6 PM", priority: .low, createDate: Date())
        ]
    }

    func fetchScheduleList() -> Observable<[Schedule]> {
        return Observable.just(schedules)
    }

    func saveSchedule(_ schedule: Schedule) -> Observable<Void> {
        if let index = schedules.firstIndex(where: { $0.uid == schedule.uid }) {
            schedules[index] = schedule
        } else {
            schedules.append(schedule)
        }
        return Observable.just(())
    }
    
    func updateSchedule(_ schedule: Schedule) -> Observable<Void> {
        return Observable.just(())
    }

    func deleteSchedule(_ schedule: Schedule) -> Observable<Void> {
        schedules.removeAll { $0.uid == schedule.uid }
        return Observable.just(())
    }
}
