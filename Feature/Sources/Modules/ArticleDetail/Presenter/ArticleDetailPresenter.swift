//
//  ArticleDetailPresenter.swift
//
//
//  Created by 長谷川稔樹 on 2023/10/08.
//

import DomainModel
import Foundation
import PresenterProtocol

struct ArticleDetailUiState {
    let article: ArticleModel
}

protocol ArticleDetailPresentation: Presentation where UIState == ArticleDetailUiState {}

final class ArticleDetailPresenter: ArticleDetailPresentation {
    @Published private(set) var uiState: ArticleDetailUiState
    
    init(router: some ArticleDetailWireframe, article: ArticleModel) {
        self.uiState = ArticleDetailUiState(article: article)
    }
}

extension ArticleDetailPresenter {
}
