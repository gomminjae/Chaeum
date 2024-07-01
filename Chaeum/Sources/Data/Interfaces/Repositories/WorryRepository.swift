//
//  WorryRepository.swift
//  Chaeum
//
//  Created by 권민재 on 7/2/24.
//

import Foundation


protocol WorryRepository {
    func save(worry: Worry)
    func fetchAll() -> [Worry]
    func delete(worry: Worry)
}

class WorryRepositoryImpl: WorryRepository {
    
    private let realmManager = RealmManager<Worry>()
    
    func save(worry: Worry) {
        realmManager.save(worry)
    }
    
    func fetchAll() -> [Worry] {
        realmManager.fetchAll()
    }
    
    func delete(worry: Worry) {
        realmManager.delete(worry)
    }
    
    
}
