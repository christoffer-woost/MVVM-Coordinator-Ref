//
//  View.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 03.07.21.
//

import UIKit

class View: UIView {
    
    var customConstraints: [NSLayoutConstraint] {[]}
    
    init() {
        super.init(frame: .zero)
        createSubviews()
        NSLayoutConstraint.activate(customConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubviews() {}
    
}

extension View {
    
    override func addSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        super.addSubview(view)
    }
    
}
