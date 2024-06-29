//
//  ReusableIdentifier.swift
//  Chaeum
//
//  Created by 권민재 on 6/27/24.
//

import Foundation



extension NSObject {
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
