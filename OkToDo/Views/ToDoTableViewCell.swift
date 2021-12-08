//
//  ToDoTableViewCell.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 01/12/2021.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    func configure(task: Task) {
        textLabel?.text = task.name
        detailTextLabel?.text = Utils.dateToString(task.date)
        
        guard let category = task.category else {
            imageView?.image = nil
            backgroundColor = .white
            textLabel?.textColor = .black
            detailTextLabel?.textColor = .black
            return
        }
        
        backgroundColor = UIColor(hex: category.backColor)
        textLabel?.textColor = UIColor(hex: category.textColor)
        detailTextLabel?.textColor = textLabel?.textColor
        
        guard let iconData = category.icon else {
            imageView?.image = nil
            return
        }
        
        imageView?.image = UIImage(data: iconData)
    }
}
