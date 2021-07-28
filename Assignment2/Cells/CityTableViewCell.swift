//
//  CityTableViewCell.swift
//  Assignment2
//
//  Created by Gökberk Köksoy on 28.07.2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    let cityLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel() {
        cityLabel.textAlignment = .natural
        cityLabel.textColor = Colors.text
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont.systemFont(ofSize: Constants.cellFontSize)
    }
    
    private func configure() {
        configureLabel()
        backgroundColor = .clear
        accessoryType = .disclosureIndicator
        contentView.addSubview(cityLabel)
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.doublePadding),
                cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.negativePadding)
        ])
    }

}
