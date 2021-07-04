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
    
    private var project: Item
    
    required init(navigationController: UINavigationController, project: Item) {
        self.navigationController = navigationController
        self.project = project
    }
    
    func start() {
        showProjectDetailScreen()
    }
    
    func showProjectDetailScreen() {
        let viewModel = ProjectDetailViewModel(project: project)
        let vc = ProjectDetailViewController(viewModel: viewModel)
        navigationController.present(vc, animated: true)
    }
    
}
