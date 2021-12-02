//
//  UIStackView + Extension.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 02/12/2021.
//

import UIKit

extension UIStackView {
    
    convenience init(subviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: subviews)
        self.axis = axis
        self.spacing = spacing
    }
}
