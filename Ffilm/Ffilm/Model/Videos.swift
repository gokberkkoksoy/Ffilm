//
//  Videos.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 19.08.2021.
//

import Foundation

struct Videos: Codable {
    var id: Int?
    var results: [Video]?
}

struct Video: Codable {
    var key: String?
    var site: String?
    var type: String?
}
