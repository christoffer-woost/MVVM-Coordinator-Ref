//
//  ProjectDetailViewController.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 04.07.21.
//

import UIKit
import Combine

class ProjectDetailViewController: ViewController<ProjectDetailView> {
    
    let viewModel: ProjectDetailViewModelInterface
    
    init(viewModel: ProjectDetailViewModelInterface) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        viewModel.$project
            .map { $0?.name }
            .sink { [weak self] score in
                self?.customView.titleLabel.text = score
            }
            .store(in: &cancellables)
        
        viewModel.$project
            .map { $0?.owner.login }
            .sink { [weak self] data in
                self?.customView.messageLabel.text = data
            }
            .store(in: &cancellables)
        
        viewModel.$project
            .map { $0?.stargazersCount }
            .sink { data in
                let starAttachment = NSTextAttachment()
                starAttachment.image = UIImage(systemName: "star")
                let starString = NSMutableAttributedString()
                starString.append(NSAttributedString(attachment: starAttachment))
                starString.append(NSAttributedString(string: " \(data ?? 0)"))
                self.customView.starsLabel.attributedText = starString
            }
            .store(in: &cancellables)
        
        viewModel.$project
            .map { $0?.createdAt }
            .sink { data in
                self.customView.dateLabel.text = data?.dateString
            }
            .store(in: &cancellables)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.startUpdating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.endUpdating()
    }
    
}
