//
//  TaskTableViewCell.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 04/12/2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    let containerView = UIView()
    
    func configure(view: UIView) {
        containerView.backgroundColor = Colors.mainWhite
        setupConstraints(view)
    }
}

// MARK: - Setup Constraints

extension TaskTableViewCell {
    
    private func setupConstraints(_ view: UIView) {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            view.heightAnchor.constraint(equalToConstant: 50),
            view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
        ])
    }
}
