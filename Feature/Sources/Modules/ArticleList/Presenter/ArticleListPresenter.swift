//
//  ArticleListPresenter.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import Dependencies
import DomainModel
import Foundation
import PresenterProtocol
import Usecase
import UseCaseContainer

struct ArticleListUIState: Equatable {
    var articleList: [ArticleModel] = []
    var isDisplayProgressView: Bool = false
}

enum ArticleListError {
    case articleListGetError(ArticleListGetError)
}

protocol ArticleListPresentation: Presentation where UIState == ArticleListUIState {}

final class ArticleListPresenter: ArticleListPresentation {
    private let router: any ArticleListWireframe
    @Published private(set) var uiState: ArticleListUIState
    @Published private(set) var articleListError: ArticleListError?
    
    @Dependency(\.articleListGetInteractor) private var articleListGetInteractor
    
    init(router: some ArticleListWireframe) {
        self.router = router
        self.uiState = ArticleListUIState()
    }
}

extension ArticleListPresenter {
    func getArticleList(of keyword: String) async {
        // 検索開始前にリストを空にする
        uiState.articleList.removeAll()
        uiState.isDisplayProgressView = true
        
        do {
            let articleModels = try await articleListGetInteractor.execute(keyword)
            uiState.articleList = articleModels
        } catch {
            articleListError = .articleListGetError(error as! ArticleListGetError)
        }
        
        uiState.isDisplayProgressView = false
    }
    
    func didSelect(of article: ArticleModel) {
        router.navigation(to: .articleDetail(article))
    }
}
