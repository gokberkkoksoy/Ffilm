//
//  ViewController.swift
//  A3
//
//  Created by Gökberk Köksoy on 29.07.2021.
//

import UIKit
import Kingfisher

class TeamListVC: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var teamInfo = TeamInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.setDoubleItemLayout(in: view)
        getTeams()
    }
    
    private func getTeams() {
        Network.shared.getNames { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let teams):
                self.teamInfo.setTeams(with: teams)
                DispatchQueue.main.async { self.collectionView.reloadData() }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension TeamListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return teamInfo.teams.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuseID, for: indexPath) as? TeamCell else {
            print(Constants.errorMessage)
            return UICollectionViewCell()
        }
        cell.teamNameLabel.text = teamInfo.teams[indexPath.item].strTeam ?? ""
        cell.teamBadgeImageView.kf.setImage(with: URL(string: teamInfo.teams[indexPath.item].strTeamBadge ?? ""))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        teamInfo.teams[indexPath.item].showInfo(on: self)
    }
}

