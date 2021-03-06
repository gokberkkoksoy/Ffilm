//
//  FFImageView.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 4.08.2021.
//

import UIKit
import Kingfisher

class FFImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = UIConstants.imageViewCornerRadius
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImage(url: URL?) {
        guard let imageURL = url else { return }
        kf.indicatorType  = .activity
        kf.setImage(with: imageURL, placeholder: Images.placeholder)
    }
}
