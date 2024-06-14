//
//  AppSettings.swift
//  Chaeum
//
//  Created by 권민재 on 5/31/24.
//


import UIKit

@propertyWrapper
struct UserDefault<T> {
    private let key: String
    private let value: T
    
    init(key: String, value: T) {
        self.key = key
        self.value = value
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? value
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
    
    
}
