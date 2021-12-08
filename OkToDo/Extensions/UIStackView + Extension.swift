//
//  UIStackView + Extension.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 02/12/2021.
//

import UIKit

extension UIStackView {
    
    convenience init(_ subviews: [UIView], _ axis: NSLayoutConstraint.Axis, _ spacing: CGFloat = 0) {
        self.init(arrangedSubviews: subviews)
        self.distribution = .fillEqually
        self.alignment = .fill
        self.spacing = spacing
        self.axis = axis
    }
}
