//
//  MockArticleListGetInteractor.swift
//
//
//  Created by 長谷川稔樹 on 2023/12/25.
//

import DomainModel
import Usecase

final class MockArticleListGetInteractor: ArticleListGetUseCase {
    private(set) var executeCallCount = 0
    var executeResult: Result<[ArticleModel], ArticleListGetError>!
    func execute(_ input: String) async throws -> [ArticleModel] {
        executeCallCount += 1
        
        switch executeResult {
        case .success(let success):
            return success
            
        case .failure(let failure):
            throw failure
            
        case .none:
            fatalError()
        }
    }
}