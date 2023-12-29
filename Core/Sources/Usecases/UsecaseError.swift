//
//  UsecaseError.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import Foundation
import Repository

public protocol UsecaseError: LocalizedError, Equatable {
    associatedtype Error: RepositoryError
    
    init(error: Error?)
}
