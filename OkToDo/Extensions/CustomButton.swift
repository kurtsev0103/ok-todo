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
        
        switch type {
        case .addButton:
            setTitle("+", for: .normal)
            setupAsRoundButton()
        case .saveButton:
            setTitle(kSaveString, for: .normal)
            setupAsNormalButton()
        case .cancelButton:
            setTitle(kCancelString, for: .normal)
            setupAsNormalButton()
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? buttonColor : .clear
        }
    }
}

extension CustomButton {
    
    private func setupAsRoundButton() {
        self.buttonColor = Colors.niceBlue
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
    
    private func setupAsNormalButton() {
        self.buttonColor = Colors.niceBlue
        setTitleColor(buttonColor, for: .normal)
        setTitleColor(.white, for: .highlighted)
        
        titleLabel?.font = Fonts.avenir20
        titleLabel?.shadowColor = Colors.niceDark
        titleLabel?.shadowOffset = CGSize(width: 4, height: 4)
        
        layer.borderWidth = 3
        layer.cornerRadius = 20
        layer.borderColor = buttonColor.cgColor
        clipsToBounds = true
    }
}
