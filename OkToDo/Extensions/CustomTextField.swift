//
//  CustomTextField.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 02/12/2021.
//

import UIKit

class CustomTextField: UITextField {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
        
        leftView = UIView()
        leftViewMode = .always
        
        rightView = UIView()
        rightViewMode = .always
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: 20, height: 20)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: frame.width - 20, y: 0, width: 20, height: 20)
    }
}

extension CustomTextField {
    private func setupTextField() {
        backgroundColor = .white
        textColor = Colors.niceDark
        tintColor = Colors.niceDark
        font = Fonts.avenir16
        textAlignment = .center
        autocapitalizationType = .none
        autocorrectionType = .no
        layer.cornerRadius = 20
        returnKeyType = .done
        clipsToBounds = true
    }
}
