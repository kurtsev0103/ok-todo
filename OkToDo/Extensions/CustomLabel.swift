//
//  CustomLabel.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 04/12/2021.
//

import UIKit

class CustomLabel: UILabel {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(_ text: String) {
        self.init(frame: .zero)
        
        self.text = text
        backgroundColor = .white
        textColor = Colors.niceDark
        tintColor = Colors.niceDark
        font = Fonts.avenir16
        textAlignment = .center
        
    }
    
    convenience init(_ text: String, height: CGFloat) {
        self.init(text)
        layer.cornerRadius = height * 0.5
        clipsToBounds = true
    }
}
