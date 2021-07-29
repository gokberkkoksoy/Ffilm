//
//  ViewController.swift
//  A3
//
//  Created by Gökberk Köksoy on 29.07.2021.
//

import UIKit
import Kingfisher

class TeamListVC: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    var teamInfo = TeamInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        view.backgroundColor = Constants.backgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hideBars()
    }

    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = Constants.backgroundColor
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
            case .failure(_):
                #warning("Show an error message")
            }
        }
    }
    
    private func displayInfo(of team: Team) {
        let info = team.getInfo()
        let ac = UIAlertController(title: team.strTeam ?? "", message: info, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: Constants.dismiss, style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: Constants.visit, style: .default, handler: { _ in
            self.goToWebPage(of: team)
        }))
        present(ac, animated: true)
    }
    
    private func goToWebPage(of team: Team){
        let teamPageVC = TeamPageVC()
        teamPageVC.teamName = team.strTeam
        teamPageVC.teamURL = team.strWebsite
        present(teamPageVC, animated: true)
    }
    
}

extension TeamListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return teamInfo.teams.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuseID, for: indexPath) as! TeamCell
        cell.teamNameLabel.text = teamInfo.teams[indexPath.item].strTeam ?? ""
        cell.teamBadgeImageView.kf.setImage(with: URL(string: teamInfo.teams[indexPath.item].strTeamBadge ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        displayInfo(of: teamInfo.teams[indexPath.item])
    }
}

