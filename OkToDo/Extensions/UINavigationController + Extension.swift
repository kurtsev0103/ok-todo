//
//  UINavigationController + Extension.swift
//  OkToDo
//
//  Created by Oleksandr Kurtsev on 05/12/2021.
//

import UIKit

extension UINavigationController {
    
    var previousViewController: UIViewController? {
        viewControllers.count > 1 ? viewControllers[viewControllers.count - 2] : nil
    }
    
    func popViewControllerWithCompletion(completion: @escaping () -> ()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: true)
        CATransaction.commit()
    }
    
    func pushViewControllerWithCompletion(viewController: UIViewController, completion: @escaping () -> ()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
}
