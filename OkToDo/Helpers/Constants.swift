//
//  Constants.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 01/12/2021.
//

import UIKit

struct Colors {
    static let niceBlue     = UIColor(red:  71/255, green: 108/255, blue: 137/255, alpha: 1)
    static let niceDark     = UIColor(red:  51/255, green:  51/255, blue:  51/255, alpha: 1)
    static let mainWhite    = UIColor(red: 242/255, green: 243/255, blue: 244/255, alpha: 1)
    static let placeholder  = UIColor(red:   0/255, green:   0/255, blue:   0/255, alpha: 0.25)
    static let dateField    = UIColor(red:   0/255, green:   0/255, blue:   0/255, alpha: 0.05)
}

struct Fonts {
    static let avenir16     = UIFont(name: "AvenirNextCondensed-DemiBold", size: 16)
    static let avenir20     = UIFont(name: "AvenirNextCondensed-DemiBold", size: 20)
    static let avenir50     = UIFont(name: "AvenirNextCondensed-DemiBold", size: 50)
}

let kSaveString             = "Save"
let kEditString             = "Edit"
let kDeleteString           = "Delete"
let kCancelString           = "Cancel"
let kMyTasksString          = "My tasks:"
let kCategoriesString       = "Categories"
let kTextColorString        = "Text Color"
let kBackColorString        = "Back Color"
let kCategoryPlaceholder    = "Enter a category name"
let kNewTaskString          = "Create a new task"
let kAddNewCategoryString   = "Add a new category"
let kCategoryEmptyString    = "Category not selected"
let kEmptyTasksString       = "You don't have any tasks yet"

let kAlertTitleOK           = "OK"
let kAlertError             = "Error"
let kAlertTitleConfirm      = "Confirm"
let kAlertTitleCancel       = "Cancel"
let kAlertTitleCongr        = "Congratulations"
let kAlertNewTaskMessage    = "You added a new task"
let kTaskChangedMessage     = "You have changed your task"
let kConfirmCancelMessage   = "The created task will be deleted. Do you really want to continue?"
let kConfirmDeleteTask      = "Are you sure you want to delete the task? This action is irrevocable."
let kConfirmDeleteCategory  = "Are you sure you want to delete a category? All your tasks with this category will become category-free."

let kTaskLengthError        = "Task name cannot be less than 3 characters long. Please correct it and try again."
let kCategoryLengthError    = "Category name cannot be less than 3 characters long. Please correct it and try again."

let kPlaceholderName        = "Write the name of the task"
let kPlaceholderCategory    = "Select a task category"
let kPlaceholderDate        = "Select a date:"
