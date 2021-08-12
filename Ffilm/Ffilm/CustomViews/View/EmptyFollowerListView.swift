//
//  EmptyFollowerListView.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 8.08.2021.
//

import UIKit

class EmptyFollowerListView: UIView {
    
    let messageTitleLabel = FFTitleLabel(textAlignment: .center, fontSize: 30)
    let messageBodyLabel = FFBodyLabel(textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(header title: String, body message: String) {
        self.init(frame: .zero)
        messageTitleLabel.text = title
        messageBodyLabel.text = message
    }
    
    private func configure() {
        if #available(iOS 13.0, *) { backgroundColor = .systemBackground }
        addSubviews(messageTitleLabel, messageBodyLabel)
        configureMessageTitleLabel()
        configureMessageBodyLabel()
    }
    
    private func configureMessageTitleLabel() {
        messageTitleLabel.text = "Wow, such empty."
        NSLayoutConstraint.activate([
            messageTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            messageTitleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 2 * UIConstants.padding),
            messageTitleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -2 * UIConstants.padding),
        ])
    }
    
    private func configureMessageBodyLabel() {
        messageBodyLabel.text = "Don't you have any favorite movies? There are countless movies in here. Just go and look for some."
        
        NSLayoutConstraint.activate([
            messageBodyLabel.topAnchor.constraint(equalTo: messageTitleLabel.bottomAnchor, constant: 30),
            messageBodyLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: UIConstants.padding),
            messageBodyLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -UIConstants.padding),
        ])
    }
    

    
    
    
    
}
