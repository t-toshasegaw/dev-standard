//
//  ArticleListGetUseCase.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import Dependencies
import DomainModel
import Foundation
import Repository

public enum ArticleListGetError: UsecaseError {
    case connectionError(Error)
    case requestError(Error)
    case responseError(Error)
    case logicFailure(Error)
    
    public init(error: QiitaRepositoryError?) {
        switch error {
        case .connectionError(let error):
            self = .connectionError(error)
            
        case .requestError(let error):
            self = .requestError(error)
            
        case .responseError(let error):
            self = .responseError(error)
            
        case .logicFailure(let error):
            self = .logicFailure(error)
            
        default:
            fatalError("unexpectedErrorCase")
        }
    }
}

public protocol ArticleListGetUseCase: Usecase
where Input == String,
      Output == [ArticleModel],
      Failure == ArticleListGetError {}

public final class ArticleListGetInteractor {
    private let qiitaDataStore: QiitaRepository
    
    public init(qiitaDataStore: QiitaRepository) {
        self.qiitaDataStore = qiitaDataStore
    }
}

extension ArticleListGetInteractor: ArticleListGetUseCase {
    public func execute(_ input: Input) async throws -> Output {
        do {
            return try await qiitaDataStore.getArticleList(of: input)
        } catch {
            throw Failure(error: error as? QiitaRepositoryError)
        }
    }
}
