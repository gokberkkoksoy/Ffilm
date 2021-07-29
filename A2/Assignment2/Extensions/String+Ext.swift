//
//  String+Ext.swift
//  Assignment2
//
//  Created by Gökberk Köksoy on 29.07.2021.
//

import Foundation

extension String {
    func makeURLReady() -> String {
        return self.replacingOccurrences(of: " ", with: "_")
    }
}
