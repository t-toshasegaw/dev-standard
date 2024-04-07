//
//  ArticleListPresenter.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import Environment
import DomainModel
import Foundation
import Presentation
import Usecase

struct ArticleListUIState: Equatable {
    var articleList: [ArticleModel] = []
    var isDisplayProgressView: Bool = false
    var error: ArticleListError?
}

protocol ArticleListPresentation: Presentation where UIState == ArticleListUIState {}

final class ArticleListPresenter: ArticleListPresentation {
    private let router: any ArticleListWireframe
    private let environment: any Environment
    
    @Published private(set) var uiState: ArticleListUIState
    
    init(router: some ArticleListWireframe, environment: some Environment) {
        self.router = router
        self.environment = environment
        self.uiState = ArticleListUIState()
    }
}

extension ArticleListPresenter {
    func getArticleList(of keyword: String) async {
        defer {
            uiState.isDisplayProgressView = false
        }
        // 検索開始前にリストを空にする
        uiState.articleList.removeAll()
        uiState.isDisplayProgressView = true
        
        do {
            let articleModels = try await environment.articleListGetInteractor.execute(keyword)
            uiState.articleList = articleModels
        } catch {
            uiState.error = .articleListGetError(error as! ArticleListGetError)
        }
    }
    
    func didSelect(of article: ArticleModel) async {
        router.navigation(to: .articleDetail(article))
    }
    
    func onErrorAlertDismiss() async {
        uiState.error = nil
    }
}
