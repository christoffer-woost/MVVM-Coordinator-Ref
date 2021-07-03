//
//  ProjectsOverviewCoordinator.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 03.07.21.
//

import UIKit

class ProjectsOverviewCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showProjectsOverviewScreen()
    }
    
    func showProjectsOverviewScreen() {
        let viewModel = ProjectsOverviewViewModel()
        let vc = ProjectsOverviewViewController(viewModel: viewModel)
        navigationController.setRoot(viewController: vc)
    }
    
}
