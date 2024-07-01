//
//  Todo.swift
//  Chaeum
//
//  Created by 권민재 on 7/1/24.
//

import Foundation
import RealmSwift


class Todo: Object {
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var priority: String
}
