//
//  Utils.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 03/12/2021.
//

import UIKit

struct Utils {
    
    static func dateToString(date: Date?, _ format: String = "dd.MM.yyyy") -> String? {
        guard let date = date else { return nil }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    static func validateStringLength(_ string: String?) -> (Bool, String?) {
        guard let string = string else { return (false, nil) }
        let validateString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard validateString.count >= 3 else { return (false, nil) }
        return (true, validateString)
    }
    
    static func colorFromDict(_ dict: [String: Float]) -> UIColor {
        guard let red = dict["red"], let green = dict["green"], let blue = dict["blue"] else { return UIColor() }
        return UIColor(red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255), alpha: 1.0)
    }
}
