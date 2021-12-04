//
//  Constants.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 01/12/2021.
//

import UIKit

struct Colors {
    static let niceBlue = UIColor(red:  71/255, green: 108/255, blue: 137/255, alpha: 1)
    static let niceDark = UIColor(red:  51/255, green:  51/255, blue:  51/255, alpha: 1)
    static let mainWhite = UIColor(red: 242/255, green: 243/255, blue: 244/255, alpha: 1)
}

struct Fonts {
    static let avenir16 = UIFont(name: "AvenirNextCondensed-DemiBold", size: 16)
    static let avenir20 = UIFont(name: "AvenirNextCondensed-DemiBold", size: 20)
    static let avenir50 = UIFont(name: "AvenirNextCondensed-DemiBold", size: 50)
}

let kSaveString = "Save"
let kCancelString = "Cancel"
let kMyTasksString = "My tasks:"
let kNewTaskString = "Create a new task"
let kEmptyTasksString = "You don't have any tasks yet"

let kAlertTitleConfirm = "Confirm"
let kAlertTitleCancel = "Cancel"
let kConfirmDeleteMessage = "Are you sure you want to delete the task? This action is irrevocable."

let kPlaceholderName = "Write the name of the task"
let kPlaceholderCategory = "Select a task category"
