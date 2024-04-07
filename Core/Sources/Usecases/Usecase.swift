//
//  Usecase.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import Foundation

public protocol Usecase: Sendable {
    associatedtype Input
    associatedtype Output
    associatedtype Failure: UsecaseError
    
    func execute(_ input: Input) async throws -> Output
}
