//
//  UIViewController + Extension.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 04/12/2021.
//

import UIKit

extension UIViewController {
    
    func showConfirmAlert(_ title: String?, _ message: String?, completion: @escaping () -> () = {}) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: kAlertTitleCancel, style: .cancel)
        let confirmAction = UIAlertAction(title: kAlertTitleConfirm, style: .destructive) { (_) in
            completion()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
    func showAlert(_ title: String?, _ message: String?, completion: @escaping () -> () = {}) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: kAlertTitleOK, style: .default) { (_) in
            completion()
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
