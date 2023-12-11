//
//  UsecaseDependencyValues.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/17.
//

import Dependencies
import Usecase

public extension DependencyValues {
    private enum ArticleListGetUseCaseKey: DependencyKey {
        static let liveValue: any ArticleListGetUseCase = ArticleListGetInteractor()
        static var testValue: any ArticleListGetUseCase = unimplemented()
    }
    var articleListGetInteractor: any ArticleListGetUseCase {
        get { self[ArticleListGetUseCaseKey.self] }
        set { self[ArticleListGetUseCaseKey.self] = newValue }
    }
}
