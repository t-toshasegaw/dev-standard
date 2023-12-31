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
    var articleListError: ArticleListError?
}

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

protocol ArticleListPresentation: Presentation where UIState == ArticleListUIState {}

final class ArticleListPresenter: ArticleListPresentation {
    private let router: any ArticleListWireframe
    private let environment: Environment
    
    @Published private(set) var uiState: ArticleListUIState
    
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
            uiState.articleListError = .articleListGetError(error as! ArticleListGetError)
        }
        
        uiState.isDisplayProgressView = false
    }
    
    func didSelect(of article: ArticleModel) {
        router.navigation(to: .articleDetail(article))
    }
    
    func onErrorAlertDismiss() {
        uiState.articleListError = nil
    }
}
