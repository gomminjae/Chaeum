//
//  RealmManager.swift
//  Chaeum
//
//  Created by 권민재 on 7/2/24.
//

import Foundation
import RxSwift
import RealmSwift


protocol RealmManagerProtocol {
    associatedtype Entity: Object
    
    func save(_ entity: Entity)
    func fetchAll() -> [Entity]
    func delete(_ entity: Entity)
}

class RealmManager<T: Object>: RealmManagerProtocol {
    typealias Entity = T
    
    private var realm: Realm {
        return try! Realm()
    }
    
    func save(_ entity: T) {
        try! realm.write {
            realm.add(entity, update: .modified)
        }
    }
    
    func fetchAll() -> [T] {
        let results = realm.objects(T.self)
        return Array(results)
    }
    
    func delete(_ entity: T) {
        try! realm.write {
            realm.delete(entity)
        }
    }
    
    
    
    
}
