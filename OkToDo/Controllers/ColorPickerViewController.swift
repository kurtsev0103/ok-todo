//
//  ColorPickerViewController.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 07/12/2021.
//

import UIKit
import CoreData

class ColorPickerViewController: UIViewController {
    
    private var category: Category?
    private var textColor: UIColor
    private var backColor: UIColor
    private let context: NSManagedObjectContext
    
    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: [kTextColorString, kBackColorString])
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    
    private lazy var textField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = kCategoryPlaceholder
        textField.font = Fonts.avenir16
        return textField
    }()
    
    private lazy var rSlider: UISlider = {
        let slider = UISlider()
        setupSlider(slider, withColor: .red)
        return slider
    }()
    
    private lazy var gSlider: UISlider = {
        let slider = UISlider()
        setupSlider(slider, withColor: .green)
        return slider
    }()
    
    private lazy var bSlider: UISlider = {
        let slider = UISlider()
        setupSlider(slider, withColor: .blue)
        return slider
    }()
    
    private lazy var saveButton: CustomButton = {
        let saveButton = CustomButton(type: .saveButton)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return saveButton
    }()
    
    private lazy var cancelButton: CustomButton = {
        let cancelButton = CustomButton(type: .cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return cancelButton
    }()
    
    init(context: NSManagedObjectContext, category: Category? = nil) {
        self.context = context
        self.category = category
        textColor = UIColor(hex: category?.textColor) ?? .black
        backColor = UIColor(hex: category?.backColor) ?? .white
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.mainWhite
        
        setupConstraints()
        updateLabelColors()
        textField.text = category?.name
        setSlidersValuesFrom(color: textColor)
    }
    
    private func setupSlider(_ slider: UISlider, withColor color: UIColor) {
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.tintColor = color
        slider.thumbTintColor = color
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    private func updateLabelColors() {
        textField.textColor = textColor
        textField.backgroundColor = backColor
    }
    
    private func setSlidersValuesFrom(color: UIColor) {
        rSlider.value = color.redComponent
        gSlider.value = color.greenComponent
        bSlider.value = color.blueComponent
    }
    
    // MARK: - Actions
    
    @objc private func saveAction() {
        let (isVerified, nameString) = Utils.validateStringLength(textField.text)
        
        guard isVerified else {
            showAlert(title: kAlertError, message: kCategoryLengthError)
            return
        }
        
        if category == nil {
            category = Category(context: context)
        }
        
        category?.name = nameString
        category?.textColor = textColor.toHexString()
        category?.backColor = backColor.toHexString()
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        dismiss(animated: true)
    }
    
    @objc private func cancelAction() {
        dismiss(animated: true)
    }
    
    @objc private func sliderValueChanged() {
        let color = UIColor(red: CGFloat(rSlider.value), green: CGFloat(gSlider.value), blue: CGFloat(bSlider.value), alpha: 1)
        
        switch segmentControl.selectedSegmentIndex {
        case 0: textColor = color
        case 1: backColor = color
        default: break
        }
        updateLabelColors()
    }
    
    @objc private func segmentControlValueChanged() {
        switch segmentControl.selectedSegmentIndex {
        case 0: setSlidersValuesFrom(color: textColor)
        case 1: setSlidersValuesFrom(color: backColor)
        default: break
        }
    }
}

// MARK: - Setup Constraints

extension ColorPickerViewController {
    
    private func setupConstraints() {
        let horizontalStackView = UIStackView(subviews: [cancelButton, saveButton], axis: .horizontal, spacing: 10)
        horizontalStackView.distribution = .fillEqually
        
        let array = [segmentControl, textField, rSlider, gSlider, bSlider, horizontalStackView]
        let verticalStackView = UIStackView(subviews: array, axis: .vertical, spacing: 10)
        verticalStackView.alignment = .fill
        
        view.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textField.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
