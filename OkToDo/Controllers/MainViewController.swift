//
//  MainViewController.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 01/12/2021.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    private let context: NSManagedObjectContext
    
    private let tableView = UITableView()
    private let addButton = CustomButton(type: .addButton)
    private let identifier = String(describing: ToDoTableViewCell.self)
    
    private var tasks = [Task]()
    
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
        setupMainParams()
        setupConstraints()
        setupTableView()
        setupAddButton()
    }
    
    private func setupMainParams() {
        navigationItem.title = kMyTasksString
    }
    
    private func setupTableView() {
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupAddButton() {
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
    }
    
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
    
    // MARK: - Actions
    
    @objc private func addButtonAction() {
        let vc = TaskViewController(context: context)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(tasks[indexPath.row])
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ToDoTableViewCell
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
