//
//  UITableView + Extension.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 04/12/2021.
//

import UIKit

extension UITableView {
    
    func showEmptyMessage(_ message: String) {
        let rect = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        let messageLabel = UILabel(frame: rect)
        
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.font = Fonts.avenir16
        messageLabel.textColor = Colors.niceBlue
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        
        backgroundView = messageLabel
        separatorStyle = .none
    }
    
    func restore() {
        backgroundView = nil
        separatorStyle = .singleLine
    }
}
