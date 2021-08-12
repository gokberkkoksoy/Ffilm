//
//  FFBodyLabel.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 3.08.2021.
//

import UIKit

class FFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    private func configure() {
        if #available(iOS 13.0, *) { textColor = .secondaryLabel }
        font = UIFont.preferredFont(forTextStyle: .callout)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }

}
