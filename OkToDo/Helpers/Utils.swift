//
//  Utils.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 03/12/2021.
//

import Foundation

struct Utils {
    
    private static let formatter = DateFormatter()
    
    static func dateToString(date: Date) -> String {
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}
