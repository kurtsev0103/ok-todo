//
//  CategoryViewController.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 04/12/2021.
//

import UIKit
import CoreData

protocol CategoryViewControllerDelegate {
    func getCategory(_ category: Category?)
}

class CategoryViewController: UITableViewController {
    
    var categoryDelegate: CategoryViewControllerDelegate?
    
    private var categories = [Category]()
    private let context: NSManagedObjectContext
    private let identifier = String(describing: CategoryViewController.self)
    
    private lazy var cancelButton: UIBarButtonItem = {
        let cancelButton = UIBarButtonItem(title: kCancelString, style: .done, target: self, action: #selector(cancelAction))
        return cancelButton
    }()
    
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingCategoriesFromCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = kCategoriesString
        navigationItem.setLeftBarButton(cancelButton, animated: false)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    // MARK: - Actions
    
    @objc private func cancelAction() {
        categoryDelegate?.getCategory(nil)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Fetch Request
    
    private func loadingCategoriesFromCoreData() {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = kAddNewCategoryString
            cell.textLabel?.textColor = .black
            cell.backgroundColor = .white
        } else {
            let category = categories[indexPath.row - 1]
            cell.textLabel?.text = category.name
            cell.textLabel?.textColor = UIColor(hex: category.textColor)
            cell.backgroundColor = UIColor(hex: category.backColor)
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let vc = CategoryDetailViewController(context: context)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        } else {
            categoryDelegate?.getCategory(categories[indexPath.row - 1])
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: kEditString) { [weak self] (_, _, _)  in
            tableView.setEditing(false, animated: true)
            guard let self = self else { return }
            
            let category = self.categories[indexPath.row - 1]
            let vc = CategoryDetailViewController(context: self.context, category: category)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            tableView.setEditing(false, animated: true)
        }
        
        let deleteAction = UIContextualAction(style: .normal, title: kDeleteString) { [weak self] (_, _, _)  in
            tableView.setEditing(false, animated: true)
            guard let self = self else { return }
            
            self.showConfirmAlert(nil, kConfirmDeleteCategory) { [unowned self] in
                self.context.delete(self.categories[indexPath.row - 1])
                self.categories.remove(at: indexPath.row - 1)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            }
        }
        
        deleteAction.backgroundColor = .red
        editAction.backgroundColor = .orange
        let congiguration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        congiguration.performsFirstActionWithFullSwipe = false
        return congiguration
    }
}
