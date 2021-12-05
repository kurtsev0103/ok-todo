//
//  UIStackView + Extension.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 02/12/2021.
//

import UIKit

extension UIStackView {
    
    convenience init(subviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0) {
        self.init(arrangedSubviews: subviews)
        self.alignment = .center
        self.spacing = spacing
        self.axis = axis
    }
}
