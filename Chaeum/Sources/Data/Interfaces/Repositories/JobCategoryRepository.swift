//
//  JobCategoryRepository.swift
//  Chaeum
//
//  Created by 권민재 on 7/1/24.
//

import Foundation
import RxSwift

protocol JobCategoryRepository {
    func fetchCategories() -> Observable<[String]>
    
}

class JobCategoryRepositoryImpl: JobCategoryRepository {
    func fetchCategories() -> RxSwift.Observable<[String]> {
        let categories: [String] = [
            "기획,전략", "인사,HR", "회계,세무", "개발,데이터", "디자인", "양업", "금융,보험","건설,건축","생산","복지","연구,R&D","교육","미디어","스포츠","마케팅,홍보"
        ]
        
        return Observable.just(categories)
    }
    
    
}
