//
//  TaskTableViewCell.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 04/12/2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(view: UIView) {
        contentView.backgroundColor = Colors.mainWhite
        
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 40),
            view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
}
