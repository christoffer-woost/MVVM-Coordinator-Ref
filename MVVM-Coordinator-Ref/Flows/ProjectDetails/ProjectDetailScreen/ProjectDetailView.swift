//
//  ProjectDetailView.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 04.07.21.
//

import UIKit

class ProjectDetailView: View {
    
    lazy var contentContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 16
        return v
    }()
    
    lazy var verticalStack: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 8
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 16)
        return v
    }()
    
    lazy var messageLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 12)
        return v
    }()
    
    lazy var horizontalStack: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.spacing = 8
        v.distribution = .equalSpacing
        return v
    }()
    
    lazy var starsLabel: UILabel = {
        let v = UILabel()
        return v
    }()
    
    lazy var dateLabel: UILabel = {
        let v = UILabel()
        return v
    }()
    
    override func createSubviews() {
        add(subview: contentContainer)
        contentContainer.add(subview: verticalStack)
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(messageLabel)
        verticalStack.addArrangedSubview(horizontalStack)
        horizontalStack.addArrangedSubview(starsLabel)
        horizontalStack.addArrangedSubview(dateLabel)
    }
    
    override func createConstraints() -> [NSLayoutConstraint] {[
        contentContainer.topAnchor.constraint(equalTo: topAnchor, constant: 8),
        contentContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        contentContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        
        verticalStack.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 8),
        verticalStack.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -8),
        verticalStack.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 8),
        verticalStack.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -8)
    ]}
    
    override func configure() {
        backgroundColor = .white
    }
    
}
