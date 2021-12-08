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
    }
    
    convenience init(height: CGFloat) {
        self.init(frame: .zero)
        layer.cornerRadius = height * 0.5
        clipsToBounds = true
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: 20, height: 20)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: frame.width - 20, y: 0, width: 20, height: 20)
    }
    
    private func setupTextField() {
        leftView = UIView()
        rightView = UIView()
        leftViewMode = .always
        rightViewMode = .always
        
        backgroundColor = .white
        textColor = Colors.niceDark
        tintColor = Colors.niceDark
        font = Fonts.avenir16
        textAlignment = .center
        autocapitalizationType = .none
        autocorrectionType = .no
        returnKeyType = .done
    }
}
