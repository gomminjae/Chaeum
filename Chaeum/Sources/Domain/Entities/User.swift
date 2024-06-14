//
//  User.swift
//  Chaeum
//
//  Created by 권민재 on 6/13/24.
//

import Foundation

struct User {
    @UserDefault(key: "name", defaultValue: "")
    var name: String

    @UserDefault(key: "nickname", defaultValue: "")
    var nickname: String

    @UserDefault(key: "birthdate", defaultValue: Date())
    var birthdate: Date

    @UserDefault(key: "jobCategory", defaultValue: "")
    var jobCategory: String
    
    @UserDefault(key: "goal", defaultValue: "")
    var goal: String
}
