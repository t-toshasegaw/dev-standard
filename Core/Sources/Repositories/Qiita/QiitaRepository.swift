//
//  QiitaRepository.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import DomainModel
import Foundation

public enum QiitaRepositoryError: RepositoryError {
    case connectionError(Error)
    case requestError(Error)
    case responseError(Error)
    case logicFailure(Error)
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.connectionError, connectionError),
            (.requestError, .requestError),
            (.responseError, .responseError),
            (.logicFailure, .logicFailure):
            return true
            
        default:
            return false
        }
    }
}

public protocol QiitaRepository {
    func getArticleList(of keyword: String) async throws -> [ArticleModel]
}
