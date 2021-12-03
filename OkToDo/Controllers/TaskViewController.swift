//
//  TaskViewController.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 02/12/2021.
//

import UIKit
import CoreData

class TaskViewController: UIViewController {
    
    private let context: NSManagedObjectContext
    
    private let tableView = UITableView()
    private let datePicker = UIDatePicker()
    
    private let nameTextField = CustomTextField()
    private let categoryTextField = CustomTextField()
    
    private let saveButton = CustomButton(type: .saveButton)
    private let cancelButton = CustomButton(type: .cancelButton)
    
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainParams()
        setupConstraints()
        setupDatePicker()
        setupTextFields()
        setupButtons()
    }
    
    private func setupMainParams() {
        navigationItem.title = kNewTaskString
        navigationItem.hidesBackButton = true
        view.backgroundColor = Colors.mainWhite
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.locale = .current
//        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = Colors.niceBlue
        
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents()
        datePicker.minimumDate = calendar.date(byAdding: components, to: Date())
    }
    
    private func setupTextFields() {
        nameTextField.delegate = self
        categoryTextField.delegate = self
        nameTextField.placeholder = kPlaceholderName
        categoryTextField.placeholder = kPlaceholderCategory
    }
    
    private func setupButtons() {
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func saveAction() {
        let task = Task(context: context)
        task.name = nameTextField.text
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        cancelAction()
    }
    
    @objc private func cancelAction() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension TaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Setup Constraints

extension TaskViewController {
    private func setupConstraints() {
        let array = [nameTextField, categoryTextField, datePicker, cancelButton, saveButton]
        let stackView = UIStackView(subviews: array, axis: .vertical, spacing: 10)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(equalToConstant: 40),
            
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0),
            saveButton.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0),
            
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0),
            cancelButton.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0),
            nameTextField.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0),
            
            categoryTextField.heightAnchor.constraint(equalToConstant: 40),
            categoryTextField.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0),
            categoryTextField.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0),
            
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
}
