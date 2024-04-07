//
//  ArticleListError.swift
//
//
//  Created by 長谷川稔樹 on 2024/04/07.
//

import Foundation
import Usecase

enum ArticleListError: Equatable, LocalizedError {
    case articleListGetError(ArticleListGetError)
    
    var errorDescription: String? {
        switch self {
        case .articleListGetError(let error):
            switch error {
            case .connectionError:
                "connectionError"
                
            case .requestError:
                "requestError"
                
            case .responseError:
                "responseError"
                
            case .logicFailure:
                "logicFailure"
            }
        }
    }
    
    var failureReason: String? {
        switch self {
        case .articleListGetError(let error):
            switch error {
            case .connectionError:
                "ネットワーク環境を確認してください"
                
            case .requestError, .responseError, .logicFailure:
                ""
            }
        }
    }
}
