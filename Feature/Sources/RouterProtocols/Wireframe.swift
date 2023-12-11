//
//  Wireframe.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import Combine
import Foundation

@MainActor
public protocol Wireframe: AnyObject {
    associatedtype Destination
    
    func navigation(to destination: Destination)
}
