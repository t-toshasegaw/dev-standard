//
//  ArticleListPresenter.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import Environment
import DomainModel
import Foundation
import PresenterProtocol
import Usecase

struct ArticleListUIState: Equatable {
    var articleList: [ArticleModel] = []
    var isDisplayProgressView: Bool = false
}

enum ArticleListError: Equatable {
    case articleListGetError(ArticleListGetError)
}

protocol ArticleListPresentation: Presentation where UIState == ArticleListUIState {}

final class ArticleListPresenter: ArticleListPresentation {
    private let router: any ArticleListWireframe
    private let environment: Environment
    
    @Published private(set) var uiState: ArticleListUIState
    @Published private(set) var articleListError: ArticleListError?
    
    init(router: some ArticleListWireframe, environment: Environment) {
        self.router = router
        self.environment = environment
        self.uiState = ArticleListUIState()
    }
}

extension ArticleListPresenter {
    func getArticleList(of keyword: String) async {
        // 検索開始前にリストを空にする
        uiState.articleList.removeAll()
        uiState.isDisplayProgressView = true
        
        do {
            let articleModels = try await environment.articleListGetInteractor.execute(keyword)
            uiState.articleList = articleModels
        } catch {
            articleListError = .articleListGetError(error as! ArticleListGetError)
        }
        
        uiState.isDisplayProgressView = false
    }
    
    func didSelect(of article: ArticleModel) async {
        router.navigation(to: .articleDetail(article))
    }
}
