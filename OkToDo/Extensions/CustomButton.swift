//
//  CustomButton.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 02/12/2021.
//

import UIKit

enum CustomButtonType {
    case addButton
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
        
        switch type {
        case .addButton:
            setupAsAddButton()
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? buttonColor : .clear
        }
    }
}

extension CustomButton {
    
    private func setupAsAddButton() {
        self.buttonColor = Colors.niceBlue
        setTitle("+", for: .normal)
        setTitleColor(buttonColor, for: .normal)
        setTitleColor(.black, for: .highlighted)

        titleLabel?.font = Fonts.avenir50
        titleLabel?.shadowColor = Colors.niceDark
        titleLabel?.shadowOffset = CGSize(width: 4, height: 4)
        
        layer.cornerRadius = 25
        layer.borderWidth = 3
        layer.borderColor = buttonColor.cgColor
        clipsToBounds = true
    }
}
