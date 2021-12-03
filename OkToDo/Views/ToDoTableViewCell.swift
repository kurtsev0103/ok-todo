//
//  ToDoTableViewCell.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 01/12/2021.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    func configure(task: Task) {
        textLabel?.text = task.name
    }
}
