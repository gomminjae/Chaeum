//
//  Theme.swift
//  Chaeum
//
//  Created by 권민재 on 6/2/24.
//

import UIKit


extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

extension UIColor {
    
    static let backgroundColor: UIColor = UIColor(red: 0.09, green: 0.09, blue: 0.12, alpha: 1.00)
    static let contentColor: UIColor = UIColor(hex: "#25232A")
    
    static let mainPurple: UIColor = UIColor(hex: "#88609A")
    static let subPurple: UIColor = UIColor(hex: "#BB86FC")
    static let mainPink: UIColor = UIColor(hex: "#DDA1DF")
    
    
}


