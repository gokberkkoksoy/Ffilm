//
//  GKTableView.swift
//  Assignment1
//
//  Created by Gökberk Köksoy on 28.07.2021.
//

import UIKit

class GKTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        tableFooterView = UIView(frame: .zero)
        backgroundColor = .none
        tintColor = Colors.tableTintColor
        register(GKTableViewCell.self, forCellReuseIdentifier: GKTableViewCell.reuseID)
    }
    
    

}
