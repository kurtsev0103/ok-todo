//
//  MainViewController.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 01/12/2021.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    private var tasks = [Task]()
    private let context: NSManagedObjectContext
    private let identifier = String(describing: ToDoTableViewCell.self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var addButton: CustomButton = {
        let addButton = CustomButton(type: .addButton)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        return addButton
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
        loadingTasksFromCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        
        navigationItem.title = kMyTasksString
    }
    
    // MARK: - Actions
    
    @objc private func addButtonAction() {
        let vc = TaskViewController(context: context)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Fetch Request
    
    private func loadingTasksFromCoreData() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let dateSort = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [dateSort]
        
        do {
            tasks = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // TODO: Show task in DetailViewController
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlert(title: nil, message: kConfirmDeleteMessage) { [unowned self] in
                context.delete(tasks[indexPath.row])
                tasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tasks.isEmpty {
            tableView.showEmptyMessage(kEmptyTasksString)
        } else {
            tableView.restore()
        }
        
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ToDoTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(task: tasks[indexPath.row])
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
