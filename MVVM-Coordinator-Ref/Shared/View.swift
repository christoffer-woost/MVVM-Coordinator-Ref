//
//  View.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 03.07.21.
//

import UIKit

class View: UIView {
    
    init() {
        super.init(frame: .zero)
        createSubviews()
        applyConstraint()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubviews() {}
    func applyConstraint() { NSLayoutConstraint.activate(createConstraints()) }
    func createConstraints() -> [NSLayoutConstraint] { return [] }
    func configure() {}
    
}
