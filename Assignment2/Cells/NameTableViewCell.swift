//
//  NameTableViewCell.swift
//  Assignment2
//
//  Created by Gökberk Köksoy on 28.07.2021.
//

import UIKit

class NameTableViewCell: UITableViewCell {

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
        nameLabel.font = UIFont.systemFont(ofSize: Constants.cellFontSize)
    }
    
    private func configure() {
        configureLabel()
        backgroundColor = .clear
        accessoryType = .none
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.doublePadding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.negativePadding)
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
