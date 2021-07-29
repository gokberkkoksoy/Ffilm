//
//  Team.swift
//  A3
//
//  Created by Gökberk Köksoy on 29.07.2021.
//

import UIKit

struct Team: Codable {
    let strTeam: String?
    let strTeamBadge: String?
    let strWebsite: String?
    let intFormedYear: String?
    let strStadium: String?
    let strStadiumLocation: String?
    
    func getInfo() -> String {
        "Founded: \(intFormedYear ?? "-")\nGround: \(strStadium ?? "-")\nLocation: \(strStadiumLocation ?? "-")"
    }
}
