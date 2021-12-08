//
//  UIColor + Extension.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 06/12/2021.
//

import UIKit

extension UIColor {
    
    convenience init?(hex: String?, alpha: CGFloat = 1.0) {
        guard let hex = hex else { return nil }
        
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        guard hexFormatted.count == 6 else { return nil }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        let r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb: Int = (Int)(r * 255)<<16 | (Int)(g * 255)<<8 | (Int)(b * 255)<<0
        return String(format:"#%06x", rgb)
    }
    
    var redComponent: Float {
        var red: CGFloat = 0.0
        getRed(&red, green: nil, blue: nil, alpha: nil)
        return Float(red)
    }
    
    var greenComponent: Float {
        var green: CGFloat = 0.0
        getRed(nil, green: &green, blue: nil, alpha: nil)
        return Float(green)
    }
    
    var blueComponent: Float {
        var blue: CGFloat = 0.0
        getRed(nil, green: nil, blue: &blue, alpha: nil)
        return Float(blue)
    }
    
    var alphaComponent: Float {
        var alpha: CGFloat = 0.0
        getRed(nil, green: nil, blue: nil, alpha: &alpha)
        return Float(alpha)
    }
}
