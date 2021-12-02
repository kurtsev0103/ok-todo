//
//  CustomTextField.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 02/12/2021.
//

import UIKit

enum TextFieldType {
    case name
    case date
    case category
}

class CustomTextField: UITextField {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    convenience init(type: TextFieldType) {
        self.init()
        
        leftViewMode = .always
        rightViewMode = .always
        
        leftView = UIView()
        rightView = UIView()
        
        switch type {
        case .name:
            placeholder = kPlaceholderName
        case .date:
            placeholder = kPlaceholderDate
        case .category:
            placeholder = kPlaceholderCategory
        }
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: 20, height: 20)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: frame.width - 20, y: frame.height - 20, width: 20, height: 20)
    }
    
    private func setupTextField() {
        backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        textColor = Colors.niceDark
        tintColor = Colors.niceDark
        font = Fonts.avenir16
        textAlignment = .center
        autocapitalizationType = .none
        autocorrectionType = .no
        layer.cornerRadius = 20
        returnKeyType = .next
        clipsToBounds = true
    }
}
