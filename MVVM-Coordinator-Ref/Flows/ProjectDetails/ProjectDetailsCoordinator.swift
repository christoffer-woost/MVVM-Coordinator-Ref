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
    
    private var projectId: String
    
    required init(navigationController: UINavigationController, projectId: String) {
        self.navigationController = navigationController
        self.projectId = projectId
    }
    
    func start() {
        showProjectDetailScreen()
    }
    
    func showProjectDetailScreen() {
        let viewModel = ProjectDetailViewModel(projectId: projectId)
        let vc = ProjectDetailViewController(viewModel: viewModel)
        navigationController.present(vc, animated: true)
    }
    
}
