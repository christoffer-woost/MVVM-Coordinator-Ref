//
//  ViewController.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 03.07.21.
//

import UIKit
import Combine

class ViewController<ContainedView: UIView, ViewModel: Any>: UIViewController {
    
    var customView: ContainedView { self.view as! ContainedView }
    var viewModel: ViewModel
    
    var cancellables: Set<AnyCancellable> = .init()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = loadCustomView()
    }
    
    override func viewDidLoad() {
        configure()
        super.viewDidLoad()
    }
    
    func loadCustomView() -> ContainedView {
        ContainedView()
    }
    
    func configure() {}
    
}

