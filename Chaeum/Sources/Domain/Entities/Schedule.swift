//
//  Schedule.swift
//  Chaeum
//
//  Created by 권민재 on 5/28/24.
//

import Foundation
import RealmSwift

enum Priority: Int {
    case high
    case medium
    case low
}


struct Schedule {
    let uid: String
    let title: String
    let content: String
    let priority: Priority
    let createDate: Date
}



struct ScheduleList {
    
    let schedules: [Schedule]
}
