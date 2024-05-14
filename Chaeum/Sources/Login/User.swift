//
//  User.swift
//  Chaeum
//
//  Created by 권민재 on 5/13/24.
//

import Foundation

struct User: Codable {
    var nickname: String
    var email: String
    var profileImageURL: URL?
    
    init(nickname: String, email: String, profileImageURL: URL? = nil) {
        self.nickname = nickname
        self.email = email
        self.profileImageURL = profileImageURL
       
    }
    
}
