//
//  DatePickerView.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 04/12/2021.
//

import UIKit

class DatePickerView: UIView {
    
    var date: Date {
        return datePicker.date
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = Fonts.avenir20
        label.textColor = Colors.niceDark
        label.text = kPlaceholderDate
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.tintColor = Colors.niceBlue
        datePicker.setDate(Date(), animated: true)
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .compact
        } else {
            datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        }
        
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents()
        let min = calendar.date(byAdding: components, to: Date())
        datePicker.minimumDate = min
        return datePicker
    }()
    
    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.backgroundColor = Colors.niceBlue
        toolbar.setItems([space, doneButton], animated: false)
        toolbar.sizeToFit()
        return toolbar
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Colors.dateField
        textField.tintColor = .clear
        textField.textAlignment = .center
        textField.layer.cornerRadius = 8
        textField.text = Utils.dateToString(Date(), "MMM d, yyyy")
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
        textField.delegate = self
        return textField
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 13.4, *) {
            setupAsHigherVersion()
        } else {
            setupAsLesserVersion()
        }
    }
    
    @objc private func donePressed() {
        textField.text = Utils.dateToString(date, "MMM d, yyyy")
        textField.resignFirstResponder()
    }
    
    @objc private func dateChanged() {
        textField.text = Utils.dateToString(date, "MMM d, yyyy")
    }
    
}

extension DatePickerView {
    
    private func setupAsHigherVersion() {
        let stackView = UIStackView([label, datePicker], .horizontal)
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupAsLesserVersion() {
        let stackView = UIStackView([label, textField], .horizontal)
        stackView.distribution = .fill
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            textField.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
}

extension DatePickerView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
