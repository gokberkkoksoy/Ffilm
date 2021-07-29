//
//  TeamInfo.swift
//  A3
//
//  Created by Gökberk Köksoy on 29.07.2021.
//

import Foundation

struct TeamInfo {
    var teams = [Team]()
    
    mutating func setTeams(with newTeams: [Team]){
        teams = newTeams
    }
}
