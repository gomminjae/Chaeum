//
//  WorryUsecase.swift
//  Chaeum
//
//  Created by 권민재 on 7/2/24.
//

import Foundation
import RxSwift


protocol WorryUseCase {
    func saveWorry(title: String, content: String, size: Int) -> Observable<Void>
    func fetchAllWorries() -> Observable<[Worry]>
    func deleteWorry(worry: Worry) -> Observable<Void>
}


class WorryUseCaseImpl: WorryUseCase {
    
    private let repository: WorryRepository
    
    init(repository: WorryRepository) {
        self.repository = repository
    }
    
    
    func saveWorry(title: String, content: String, size: Int) -> Observable<Void> {
        let worry = Worry(title: title, content: content, size: size)
        repository.save(worry: worry)
        return .just(())
    }
    
    func fetchAllWorries() -> Observable<[Worry]> {
        let worries = repository.fetchAll()
        return .just(worries)
    }
    
    func deleteWorry(worry: Worry) -> Observable<Void> {
        repository.delete(worry: worry)
        return .just(())
    }
    
    
}
