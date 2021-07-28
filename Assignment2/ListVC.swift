//
//  ViewController.swift
//  Assignment2
//
//  Created by Gökberk Köksoy on 28.07.2021.
//

import UIKit

class ListVC: UIViewController {
    
    var array = [1,2,3,4,45,56,76,8,8,4543,54,765,4,457,657,68,76,65,7568,678]
    
    @IBOutlet var tableView: UITableView! {
        didSet {
//            tableView.tableFooterView = UIView(frame: .zero)
//            tableView.backgroundColor = .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    private func configureTableView() {
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.reuseID)
    }
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return array.count }
    
    func numberOfSections(in tableView: UITableView) -> Int { return 2 }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NameTableViewCell.reuseID, for: indexPath) as! NameTableViewCell
        cell.nameLabel.text = "\(array[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! NameTableViewCell
        cell.toggleCheckmark()
    }
    
    
}
