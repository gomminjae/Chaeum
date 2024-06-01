//
//  AppSettings.swift
//  Chaeum
//
//  Created by 권민재 on 5/31/24.
//


import UIKit

enum AppSettings {
    @Storage(key: "didInit",defaultValue: false)
    static var didInit: Bool
}
