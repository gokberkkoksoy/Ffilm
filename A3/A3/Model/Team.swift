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
    
    func showInfo(on vc: TeamListVC) {
        let infoStr = "Founded: \(intFormedYear ?? "-")\nGround: \(strStadium ?? "-")\nLocation: \(strStadiumLocation ?? "-")"
        let ac = UIAlertController(title: strTeam, message: infoStr, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Visit Webpage", style: .default, handler: nil))
        vc.present(ac, animated: true)
    }
}
