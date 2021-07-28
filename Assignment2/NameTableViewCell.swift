//
//  NameTableViewCell.swift
//  Assignment2
//
//  Created by Gökberk Köksoy on 28.07.2021.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    static let reuseID = "NameTableViewCell"
    let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel() {
        nameLabel.textAlignment = .natural
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 45)
    }
    
    private func configure() {
        configureLabel()
        backgroundColor = .clear
        accessoryType = .none
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
                    nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                    nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                    nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func toggleCheckmark() {
        if accessoryType == .none {
            accessoryType = .checkmark
        } else if accessoryType == .checkmark {
            accessoryType = .none
        }
    }
}
