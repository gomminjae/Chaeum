//
//  TabbarItem.swift
//  Chaeum
//
//  Created by 권민재 on 5/12/24.
import UIKit

enum TabbarItemType: String, CaseIterable {
    
    case home, stat, setting
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .home
        case 1:
            self = .stat
        case 2:
            self = .setting
        default:
            return nil
        }
    }
}
