//
//  TableViewCell.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 03.07.21.
//

import Foundation


import UIKit

class TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        createSubviews()
        NSLayoutConstraint.activate(createConstraints())
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: Self.className)
        createSubviews()
        NSLayoutConstraint.activate(createConstraints())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubviews() {}
    func createConstraints() -> [NSLayoutConstraint] { return [] }
    
}
