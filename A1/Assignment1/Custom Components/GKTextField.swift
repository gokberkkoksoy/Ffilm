//
//  GKTextField.swift
//  Assignment1
//
//  Created by Gökberk Köksoy on 27.07.2021.
//

import UIKit

class GKTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = Colors.textFieldLayerBorder
        
        // next 2 lines are used to add padding to the placeholder. otherwise the cursor is not shown
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        leftViewMode = .always
        
        textColor = .black
        tintColor = Colors.textfieldTint
        textAlignment = .natural
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = Colors.mainScreenBackground
        autocorrectionType = .no
        returnKeyType = .done
        clearButtonMode = .whileEditing
        attributedPlaceholder = NSAttributedString(string: "Enter your item", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightText])
    }
    
}
