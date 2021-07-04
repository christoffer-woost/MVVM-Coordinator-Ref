//
//  ProjectDetailViewModel.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 04.07.21.
//

import Foundation
import Combine

class ProjectDetailViewModelInterface: ObservableObject {
    
    @Published var project: Item
    
    init(project: Item) {
        self.project = project
    }
    
    func startUpdating() {}
    func endUpdating() {}
    
}

class ProjectDetailViewModel: ProjectDetailViewModelInterface {
    
    private var fetchCancalable: AnyCancellable?
    
    override func startUpdating() {
        fetchCancalable = Just(())
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
                APIClient.request(ProjectAPIRequest(item: self!.project))
                    .replaceError(with: self!.project)
            })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.project = result
            }
    }
    
    override func endUpdating() {
        fetchCancalable = nil
    }
    
}
