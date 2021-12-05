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
    private let identifier = String(describing: "Cell")
    
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
        navigationItem.setLeftBarButton(cancelButton, animated: true)
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
        } else {
            cell.textLabel?.text = categories[indexPath.row - 1].name
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            // TODO: Add new category in New VC
        } else {
            categoryDelegate?.getCategory(categories[indexPath.row - 1])
            navigationController?.popViewController(animated: true)
        }
    }
}
