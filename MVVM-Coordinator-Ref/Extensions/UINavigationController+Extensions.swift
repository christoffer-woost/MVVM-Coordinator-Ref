//
//  UINavigationController+Extensions.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 03.07.21.
//

import UIKit

extension UINavigationController {
    
    func setRoot(viewController: UIViewController) {
        self.viewControllers = [viewController]
    }
    
}
