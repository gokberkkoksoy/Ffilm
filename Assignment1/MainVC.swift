//
//  ViewController.swift
//  Assignment1
//
//  Created by Gökberk Köksoy on 27.07.2021.
//

import UIKit

class MainVC: UIViewController {
    
    private let addItemTextField = GKTextField()
    private let tableView = GKTableView()
    private let button = GKButton(backgroundColor: Colors.buttonBackground, title: "SUBMIT")
    private var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(addItemTextField,tableView,button)
        view.backgroundColor = Colors.mainScreenBackground
        items = Storage.get(for: Storage.key) as? [String] ?? []
        configureTextField()
        createDismissKeyboardTapGesture()
        configureButton()
        configureTableView()
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func configureTextField() {
        addItemTextField.delegate = self
        
        NSLayoutConstraint.activate([
            addItemTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            addItemTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            addItemTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            addItemTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: addItemTextField.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: button.topAnchor)
        ])
    }
    
    func addItem(item: String?){
        if item != nil {
            items.append(item!)
        }
        DispatchQueue.main.async { self.tableView.reloadData() }
        Storage.store(items: items, key: Storage.key)
    }
    
    private func configureButton() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    @objc private func buttonTapped() {
        addItem(item: addItemTextField.text)
    }
    
}

extension MainVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addItem(item: textField.text)
        textField.resignFirstResponder()
        return true
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GKTableViewCell.reuseID) as! GKTableViewCell
        cell.set(title: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        items.remove(at: indexPath.row)
        Storage.store(items: items, key: Storage.key)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}
