//
//  ProjectsOverviewViewModel.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 03.07.21.
//

import Foundation
import Combine

struct Project: Decodable {}

class ProjectsOverviewViewModelInterface: ObservableObject {
    @Published var projects: [Project] = []
    
    func fetch() {}
}

class ProjectsOverviewViewModel: ProjectsOverviewViewModelInterface {
    
    override func fetch() {
        projects.append(Project())
    }
    
}
