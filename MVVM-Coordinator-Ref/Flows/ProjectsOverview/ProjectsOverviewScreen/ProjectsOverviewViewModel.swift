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
    @Published var projects: [Item] = []
    
    func fetch() {}
    func startUpdating() {}
    func endUpdating() {}
}

class ProjectsOverviewViewModel: ProjectsOverviewViewModelInterface {
    
    private var fetchCancalable: AnyCancellable?
    
    override func fetch() {
        
    }
    
    override func startUpdating() {
        fetchCancalable = //Publishers.MergeMany(
            Just(())
            .receive(on: DispatchQueue.main)
            .map { _ in }
            .eraseToAnyPublisher()
            .merge(with: Timer
                    .publish(every: 10, on: .main, in: .default)
                    .autoconnect()
                    .map{ _ in }
                    .eraseToAnyPublisher()
            )
            .flatMap({ [weak self] _ in
                APIClient.request(ProjectsAPIRequest())
                    .map { $0.items }
                    .replaceError(with: self?.projects ?? [])
            })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                print("new proj: \(result.count)")
                self?.projects = result
            }
    }
    
    override func endUpdating() {
        fetchCancalable = nil
    }
    
}
