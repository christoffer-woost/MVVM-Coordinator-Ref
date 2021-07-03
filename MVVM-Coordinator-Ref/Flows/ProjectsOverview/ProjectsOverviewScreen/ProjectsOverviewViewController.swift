//
//  ProjectsOverviewViewController.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 03.07.21.
//

import UIKit
import Combine

class ProjectsOverviewViewController: ViewController<ProjectsOverviewView> {
    
    let viewModel: ProjectsOverviewViewModelInterface
    
    init(viewModel: ProjectsOverviewViewModelInterface) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        customView.tableView.dataSource = self
        
        viewModel.$projects
            .sink { [weak self] _ in
                self?.customView.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        customView.refreshControl
            .publisher(for: .valueChanged)
            .sink { [weak self] _ in
                self?.viewModel.fetch()
                self?.customView.refreshControl.endRefreshing()
            }
            .store(in: &cancellables)
        
        viewModel.fetch()
    }
    
}

extension ProjectsOverviewViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = [UIColor.red, .blue, .yellow, .purple, .brown].randomElement()
        return cell
    }
    
}
