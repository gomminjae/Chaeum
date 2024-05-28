//
//  ViewModelType.swift
//  Chaeum
//
//  Created by 권민재 on 5/28/24.
//

import Foundation


protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
