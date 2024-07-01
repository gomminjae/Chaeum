//
//  Worry.swift
//  Chaeum
//
//  Created by 권민재 on 7/1/24.
//

import Foundation
import RealmSwift



class Worry: Object {
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var size: Int
    
    convenience init(title: String, content: String, size: Int) {
        self.init()
        self.title = title
        self.content = content
        self.size = size 
    }
}
