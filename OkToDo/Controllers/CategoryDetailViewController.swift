//
//  CategoryDetailViewController.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 07/12/2021.
//

import UIKit
import CoreData

class CategoryDetailViewController: UITableViewController {
    
    private var category: Category?
    private var textColor: UIColor
    private var backColor: UIColor
    private var categoryImage: UIImage?
    private let context: NSManagedObjectContext
    private let identifier = String(describing: StaticTableViewCell.self)
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: kTaskImagePlaceholder)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: [kTextColorString, kBackColorString])
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    
    private lazy var textField: CustomTextField = {
        let textField = CustomTextField(height: 40)
        textField.placeholder = kCategoryPlaceholder
        textField.font = Fonts.avenir16
        textField.delegate = self
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
        let saveButton = CustomButton(type: .saveButton, height: 40)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return saveButton
    }()
    
    private lazy var cancelButton: CustomButton = {
        let cancelButton = CustomButton(type: .cancelButton, height: 40)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return cancelButton
    }()
    
    init(context: NSManagedObjectContext, category: Category? = nil) {
        self.context = context
        self.category = category
        textColor = UIColor(hex: category?.textColor) ?? .black
        backColor = UIColor(hex: category?.backColor) ?? .white
        
        if let data = category?.icon {
            categoryImage = UIImage(data: data)
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.mainWhite
        
        updateLabelColors()
        textField.text = category?.name
        setSlidersValuesFrom(color: textColor)
        
        if let categoryImage = categoryImage {
            self.imageView.image = categoryImage
        }
        
        tableView.separatorColor = .clear
        tableView.register(StaticTableViewCell.self, forCellReuseIdentifier: identifier)
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
            showAlert(kAlertError, kCategoryLengthError)
            return
        }
        
        if category == nil {
            category = Category(context: context)
        }
        
        category?.name = nameString
        category?.icon = categoryImage?.pngData()
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

// MARK: - UITableViewDataSource && UITableViewDelegate

extension CategoryDetailViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? StaticTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0: cell.configure(view: imageView, height: 100)
        case 1: cell.configure(view: textField)
        case 2: cell.configure(view: segmentControl)
        case 3: cell.configure(view: rSlider)
        case 4: cell.configure(view: gSlider)
        case 5: cell.configure(view: bSlider)
        case 6: cell.configure(view: cancelButton)
        case 7: cell.configure(view: saveButton)
        default: break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 120
        default: return 60
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            imageTapped()
        }
    }
}

// MARK: - Image Picker Avatar

extension CategoryDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func imageTapped() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let photo = UIAlertAction(title: kAlertTitleGallery, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.chooseImagePicker(source: .photoLibrary)
        }
        
        let remove = UIAlertAction(title: kDeleteString, style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.imageView.image = UIImage(named: kTaskImagePlaceholder)
            self.categoryImage = nil
        }
        
        let cancel = UIAlertAction(title: kAlertTitleCancel, style: .cancel)
        
        actionSheet.addAction(photo)
        actionSheet.addAction(remove)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }

    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        categoryImage = imageView.image
        dismiss(animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension CategoryDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
