//
//  Storage.swift
//  Assignment1
//
//  Created by Gökberk Köksoy on 27.07.2021.
//

import Foundation

struct Storage {
    static let defaults = UserDefaults.standard
    static let key = "udItems"
    
    static func store(items: [String], key: String) {
        defaults.set(items, forKey: key)
    }
    
    static func get(for key: String) -> Any? {
        return defaults.object(forKey: key)
    }
    
}
