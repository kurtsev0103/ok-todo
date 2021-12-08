//
//  TaskViewController.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 02/12/2021.
//

import UIKit
import CoreData

class TaskViewController: UITableViewController {
    
    private var task: Task?
    private var category: Category?
    private let context: NSManagedObjectContext
    private let identifier = String(describing: TaskTableViewCell.self)
    
    private lazy var nameTextField: CustomTextField = {
        let nameTextField = CustomTextField(height: 40)
        nameTextField.placeholder = kPlaceholderName
        nameTextField.delegate = self
        return nameTextField
    }()
    
    private lazy var categoryLabel: CustomLabel = {
        let categoryLabel = CustomLabel(kCategoryEmptyString, height: 40)
        categoryLabel.textColor = Colors.placeholder
        return categoryLabel
    }()
    
    private lazy var datePickerView: DatePickerView = {
        let datePickerView = DatePickerView()
        return datePickerView
    }()
    
    private lazy var saveButton: CustomButton = {
        let saveButton = CustomButton(type: .saveButton, height: 40)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return saveButton
    }()
    
    private lazy var cancelButton: CustomButton = {
        let cancelButton = CustomButton(type: .cancelButton, height: 40)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return cancelButton
    }()
    
    init(context: NSManagedObjectContext, task: Task? = nil) {
        self.context = context
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.separatorColor = .clear
        
        navigationItem.hidesBackButton = true
        navigationItem.title = kNewTaskString
        view.backgroundColor = Colors.mainWhite
        
        category = task?.category
        nameTextField.text = task?.name
        datePickerView.date = task?.date ?? Date()
        
        if let category = category {
            categoryLabel.text = category.name
            categoryLabel.textColor = Colors.niceDark
        }
    }
    
    // MARK: - Actions
    
    @objc private func saveAction() {
        let (isVerified, nameString) = Utils.validateStringLength(nameTextField.text)
        
        guard isVerified else {
            showAlert(kAlertError, kTaskLengthError)
            return
        }
        
        let isNewTask = (task == nil)
        
        if task == nil {
            task = Task(context: context)
        }
        
        task?.name = nameString
        task?.category = category
        task?.date = datePickerView.date
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        
        guard let navigationController = navigationController else { return }
        navigationController.popViewControllerWithCompletion {
            navigationController.showAlert(kAlertTitleCongr, isNewTask ? kAlertNewTaskMessage : kTaskChangedMessage)
        }
    }
    
    @objc private func cancelAction() {
        guard nameTextField.text?.isEmpty ?? true else {
            showConfirmAlert(nil, kConfirmCancelMessage) { [unowned self] in
                navigationController?.popViewController(animated: true)
            }
            return
        }
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource && UITableViewDelegate

extension TaskViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0: cell.configure(view: nameTextField)
        case 1: cell.configure(view: categoryLabel)
        case 2: cell.configure(view: datePickerView)
        case 3: cell.configure(view: cancelButton)
        case 4: cell.configure(view: saveButton)
        default: break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 1 {
            let vc = CategoryViewController(context: context)
            vc.categoryDelegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UITextFieldDelegate

extension TaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - CategoryViewControllerDelegate

extension TaskViewController: CategoryViewControllerDelegate {
    
    func getCategory(_ category: Category?) {
        self.category = category
        
        guard let category = category, let name = category.name else {
            categoryLabel.text = kCategoryEmptyString
            categoryLabel.textColor = Colors.placeholder
            return
        }
        
        categoryLabel.text = name
        categoryLabel.textColor = Colors.niceDark
    }
}
