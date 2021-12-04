//
//  UIViewController + Extension.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 04/12/2021.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?, completion: @escaping () -> () = {}) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: kAlertTitleCancel, style: .cancel)
        let confirmAction = UIAlertAction(title: kAlertTitleConfirm, style: .destructive) { (_) in
            completion()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
}
