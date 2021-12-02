//
//  TaskViewController.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 02/12/2021.
//

import UIKit

class TaskViewController: UIViewController {
    
    private let tableView = UITableView()
    private let saveButton = CustomButton(type: .saveButton)
    private let cancelButton = CustomButton(type: .cancelButton)
    
    private let nameTextField = CustomTextField(type: .name)
    private let dateTextField = CustomTextField(type: .date)
    private let categoryTextField = CustomTextField(type: .category)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        view.backgroundColor = Colors.mainWhite
        
        setupConstraints()
        setupButtons()
    }
    
    private func setupButtons() {
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func saveAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cancelAction() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Setup Constraints

extension TaskViewController {
    private func setupConstraints() {
        let array = [nameTextField, dateTextField, categoryTextField, cancelButton, saveButton]
        let stackView = UIStackView(subviews: array, axis: .vertical, spacing: 10)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            dateTextField.heightAnchor.constraint(equalToConstant: 40),
            categoryTextField.heightAnchor.constraint(equalToConstant: 40),
           
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
}
