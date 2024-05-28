//
//  DesignSystemFont.swift
//  Chaeum
//
//  Created by 권민재 on 5/28/24.
//
import UIKit


enum DesignSystemFont {
    case title
    case content
}

extension DesignSystemFont {
    var value: UIFont {
        switch self {
        case .title:
            return UIFont.boldSystemFont(ofSize: 20)
        case .content:
            return UIFont.systemFont(ofSize: 16)
            
        }
    }
}
