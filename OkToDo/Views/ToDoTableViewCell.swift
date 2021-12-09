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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.frame.height - 4
        imageView?.frame = CGRect(x: 2, y: 2, width: size, height: size)
        imageView?.layer.cornerRadius = size * 0.5
        imageView?.layer.borderColor = Colors.niceBlue.cgColor
        imageView?.layer.borderWidth = 2
        imageView?.clipsToBounds = true
        
        textLabel?.frame.origin.x = 8
        detailTextLabel?.frame.origin.x = 8
        
        if imageView?.image != nil {
            textLabel?.frame.origin.x += size
            detailTextLabel?.frame.origin.x += size
        }
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
