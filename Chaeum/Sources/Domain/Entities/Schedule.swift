//
//  Schedule.swift
//  Chaeum
//
//  Created by 권민재 on 5/28/24.
//

import Foundation


struct Schedule {
    let uid: String
    let title: String
    let content: String
    let createData: Date
}

struct ScheduleList {
    
    let schedules: [Schedule]
}
