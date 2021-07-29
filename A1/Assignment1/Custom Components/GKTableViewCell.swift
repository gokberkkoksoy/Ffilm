//
//  GKTableViewCell.swift
//  Assignment1
//
//  Created by Gökberk Köksoy on 27.07.2021.
//

import UIKit

class GKTableViewCell: UITableViewCell {
    
    static let reuseID = "ItemCell"
    let itemLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel() {
        itemLabel.textAlignment = .natural
        itemLabel.textColor = .black
        itemLabel.adjustsFontSizeToFitWidth = true
        itemLabel.minimumScaleFactor = 0.9 // for very large texts, font size can decrease by 10%
        itemLabel.lineBreakMode = .byTruncatingTail
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.font = UIFont.systemFont(ofSize: 45)
    }
    
    func set(title text: String) { itemLabel.text = text }
    
    private func configureCell() {
        configureLabel()
        backgroundColor = .clear
        
        contentView.addSubview(itemLabel)
        NSLayoutConstraint.activate([
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            itemLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            itemLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
}
