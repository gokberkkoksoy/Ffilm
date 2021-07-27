//
//  ViewController.swift
//  Assignment1
//
//  Created by Gökberk Köksoy on 27.07.2021.
//

import UIKit

class MainVC: UIViewController {
    
    private let addItemTextField = GKTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        view.addSubview(addItemTextField)
        configureTextField()
        createDismissKeyboardTapGesture()
    }
    
    private func configureTextField() {
        addItemTextField.delegate = self
        
        NSLayoutConstraint.activate([
            addItemTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            addItemTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addItemTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addItemTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}

extension MainVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

