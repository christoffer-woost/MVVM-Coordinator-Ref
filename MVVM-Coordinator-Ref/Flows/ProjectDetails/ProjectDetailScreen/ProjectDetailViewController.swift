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
