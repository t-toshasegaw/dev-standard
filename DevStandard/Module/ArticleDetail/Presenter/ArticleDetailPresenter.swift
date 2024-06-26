//
//  LecacyPresenter.swift
//  DevStandard
//
//  Created by 長谷川稔樹 on 2023/12/06.
//

import Environment
import Foundation
import Presentation

struct ArticleDetailUIState: Equatable {
}

protocol ArticleDetailPresentation: Presentation where UIState == ArticleDetailUIState {}

final class ArticleDetailPresenter: ArticleDetailPresentation {
    private let router: any ArticleDetailWireframe
    private let environment: any Environment
    
    @Published private(set) var uiState: ArticleDetailUIState
    
    init(router: some ArticleDetailWireframe, environment: some Environment) {
        self.router = router
        self.environment = environment
        self.uiState = ArticleDetailUIState()
    }
}
