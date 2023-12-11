//
//  Presentation.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import Foundation

@MainActor
public protocol Presentation: ObservableObject {
    associatedtype UIState
    
    var uiState: UIState { get }
}
