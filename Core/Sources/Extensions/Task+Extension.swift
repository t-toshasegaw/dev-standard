//
//  Task+Extension.swift
//  
//
//  Created by 長谷川稔樹 on 2023/12/13.
//

import Combine
import Foundation

public extension Task {
    func store(in cancellables: inout Set<AnyCancellable>) {
        cancellables.insert(.init { cancel() })
    }
}
