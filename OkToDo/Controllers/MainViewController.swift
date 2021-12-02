//
//  MainViewController.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 01/12/2021.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    var context: NSManagedObjectContext!
    
    private let tableView = UITableView()
    private let addButton = CustomButton(type: .addButton)
    private let identifier = String(describing: ToDoTableViewCell.self)
    
    private var tasks = [TaskModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTableView()
        setupAddButton()
    }
    
    private func setupTableView() {
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.backgroundColor = Colors.mainWhite
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupAddButton() {
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
    }
    
    @objc private func addButtonAction() {
        navigationController?.pushViewController(TaskViewController(), animated: true)
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)/* as! ToDoTableViewCell*/
        return cell
    }
}

// MARK: - Setup Constraints

extension MainViewController {
    private func setupConstraints() {
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        let window = UIApplication.shared.windows.first
        let bottomPadding = window?.safeAreaInsets.bottom
        var bottomOffset: CGFloat = -20
        
        if bottomPadding != nil && bottomPadding == 0 {
            bottomOffset = -40
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: bottomOffset),
            
        ])
    }
}
