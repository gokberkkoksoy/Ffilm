//
//  ViewController.swift
//  Assignment2
//
//  Created by Gökberk Köksoy on 28.07.2021.
//

import UIKit

class ListVC: UIViewController {
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.tintColor = Colors.tint
            tableView.backgroundColor = Colors.background
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: Constants.nameCellID)
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: Constants.cityCellID)
    }
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Datas.names.count
        case 1:
            return Datas.cities.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { return 2 }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { return "Section \(section)" }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.nameCellID, for: indexPath) as! NameTableViewCell
            cell.nameLabel.text = Datas.names[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cityCellID, for: indexPath) as! CityTableViewCell
            cell.cityLabel.text = Datas.cities[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) as? NameTableViewCell {
            cell.toggleCheckmark()
        } else if let cell = tableView.cellForRow(at: indexPath) as? CityTableViewCell {
            let cityVC = CityVC()
            cityVC.cityName = cell.cityLabel.text
            navigationController?.pushViewController(cityVC, animated: true)
        }
    }
    
}
