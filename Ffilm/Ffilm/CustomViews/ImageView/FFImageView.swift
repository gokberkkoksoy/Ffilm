//
//  FFImageView.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 4.08.2021.
//

import UIKit

class FFImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(url: URL?) {
        guard let imageURL = url else { return }
        kf.setImage(with: imageURL)
    }
}
