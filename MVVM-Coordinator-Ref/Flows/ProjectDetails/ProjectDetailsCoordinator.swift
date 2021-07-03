//
//  ProjectDetailsCoordinator.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 03.07.21.
//

import UIKit
import Combine

class ProjectDetailsCoordinator: Coordinator, Finishing {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    var onFinished: PassthroughSubject<Void, Never> = .init()
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    
}
