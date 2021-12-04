//
//  UITableView + Extension.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 04/12/2021.
//

import UIKit

extension UITableView {

    func showEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.font = Fonts.avenir16
        messageLabel.textColor = Colors.niceBlue
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        backgroundView = messageLabel
    }

    func restore() {
        backgroundView = nil
    }
}
