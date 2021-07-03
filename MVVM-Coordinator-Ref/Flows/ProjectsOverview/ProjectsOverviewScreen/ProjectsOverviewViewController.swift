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
        title = "Repositories"
        
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        customView.tableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: ProjectTableViewCell.className)
        
        viewModel.$projects
            .delay(for: 0, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                print(self?.viewModel.projects.count)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.startUpdating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.endUpdating()
    }
    
    override var keyCommands: [UIKeyCommand]? {[
        UIKeyCommand(title: "Reload", action: #selector(refresh), input: "r", modifierFlags: .command)
    ]}
    
    @objc func refresh() {
        viewModel.fetch()
    }
    
}

extension ProjectsOverviewViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.className) as! ProjectTableViewCell
        let data = viewModel.projects[indexPath.row]
        cell.titleLabel.text = data.name
        cell.messageLabel.text = data.owner.login
        
        let starAttachment = NSTextAttachment()
        starAttachment.image = UIImage(systemName: "star")
        let starString = NSMutableAttributedString()
        starString.append(NSAttributedString(attachment: starAttachment))
        starString.append(NSAttributedString(string: " \(data.stargazersCount)"))
        cell.starsLabel.attributedText = starString
        
        cell.watchersLabel.text = data.createdAt?.dateString ?? ""
        
        return cell
    }
    
}

extension ProjectsOverviewViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.projects[indexPath.row]
        viewModel.didSelectProject.send(data)
    }
    
}
