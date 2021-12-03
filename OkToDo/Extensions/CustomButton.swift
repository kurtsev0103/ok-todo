//
//  CustomButton.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 02/12/2021.
//

import UIKit

enum CustomButtonType {
    case addButton
    case saveButton
    case cancelButton
}

class CustomButton: UIButton {
    
    private var buttonColor: UIColor!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(type: CustomButtonType) {
        self.init(type: .system)
        
        self.buttonColor = Colors.niceBlue
        setTitleColor(buttonColor, for: .normal)
        setTitleColor(.white, for: .highlighted)
        
        titleLabel?.shadowColor = Colors.niceDark
        titleLabel?.shadowOffset = CGSize(width: 4, height: 4)
        layer.borderColor = buttonColor.cgColor
        layer.borderWidth = 3
        clipsToBounds = true
        
        switch type {
        case .addButton:
            setTitle("+", for: .normal)
            titleLabel?.font = Fonts.avenir50
            layer.cornerRadius = 25
        case .saveButton:
            setTitle(kSaveString, for: .normal)
            titleLabel?.font = Fonts.avenir20
            layer.cornerRadius = 20
        case .cancelButton:
            setTitle(kCancelString, for: .normal)
            titleLabel?.font = Fonts.avenir20
            layer.cornerRadius = 20
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? buttonColor : .clear
        }
    }
}
