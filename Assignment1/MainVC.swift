//
//  ViewController.swift
//  Assignment1
//
//  Created by Gökberk Köksoy on 27.07.2021.
//

import UIKit

class MainVC: UIViewController {
    
    private let addItemTextField = GKTextField()
    private let tableView = UITableView()
    private let button = GKButton(backgroundColor: .red, title: "SUBMIT")
    private var items = ["asdf","dsfg", "wey", "786854"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
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
        view.addSubview(addItemTextField)
        addItemTextField.delegate = self
        
        NSLayoutConstraint.activate([
            addItemTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            addItemTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            addItemTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            addItemTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .none
        tableView.register(GKTableViewCell.self, forCellReuseIdentifier: GKTableViewCell.reuseID)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: addItemTextField.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: button.topAnchor)
        ])
    }
    
    func addItem(item: String?){
        if item != nil {
            items.append(item!)
        }
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    private func configureButton() {
        view.addSubview(button)
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
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}

