//
//  ProjectsOverviewCoordinator.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 03.07.21.
//

import UIKit
import Combine

class ProjectsOverviewCoordinator: Coordinator {
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showProjectsOverviewScreen()
    }
    
    private func showProjectsOverviewScreen() {
        let viewModel = ProjectsOverviewViewModel()
        viewModel.didSelectProject
            .sink { [weak self] item in
                self?.showProjectCoordinator(with: item)
            }
            .store(in: &cancellables)
        let vc = ProjectsOverviewViewController(viewModel: viewModel)
        navigationController.setRoot(viewController: vc)
    }
    
    private func showProjectCoordinator(with item: Item) {
        let coordinator = ProjectDetailsCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}
