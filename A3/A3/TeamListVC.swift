//
//  ViewController.swift
//  A3
//
//  Created by Gökberk Köksoy on 29.07.2021.
//

import UIKit

class TeamListVC: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    var test = [1,2,3,4,5,56,6,7,89,0,65,45,34665,84,754,436,]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
    }


}

extension TeamListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return test.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as? TeamCell else {
            fatalError("unable to generate cell")
        }
        cell.teamNameLabel.text = "\(test[indexPath.item])"
        cell.teamNameLabel.textColor = .systemPink
        cell.teamBadgeImageView.image = UIImage(named: "unnamed.png")
        
        return cell
        
    }
    
    
}

