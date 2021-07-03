//
//  ProjectsOverviewView.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 03.07.21.
//

import UIKit

class ProjectsOverviewView: View {
    
    lazy var refreshControl: UIRefreshControl = {
        let v = UIRefreshControl()
        return v
    }()
    
    lazy var tableView: UITableView = {
        let v = UITableView(frame: .zero, style: .plain)
        v.backgroundColor = .white
        v.separatorStyle = .none
        v.refreshControl = refreshControl
        return v
    }()
    
    override var customConstraints: [NSLayoutConstraint] {[
        tableView.topAnchor.constraint(equalTo: topAnchor),
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ]}
    
    override func createSubviews() {
        addSubview(tableView)
    }
    
}
