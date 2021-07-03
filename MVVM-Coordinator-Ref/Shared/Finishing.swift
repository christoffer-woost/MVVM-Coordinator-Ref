//
//  Finishing.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 04.07.21.
//

import Foundation
import Combine

public protocol Finishing: AnyObject {
    var onFinished: PassthroughSubject<Void, Never> { get }
}
