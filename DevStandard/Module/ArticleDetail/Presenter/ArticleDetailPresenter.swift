//
//  LecacyPresenter.swift
//  DevStandard
//
//  Created by 長谷川稔樹 on 2023/12/06.
//

import Enviroment
import Foundation
import PresenterProtocol

struct ArticleDetailUIState: Equatable {
}

protocol ArticleDetailPresentation: Presentation where UIState == ArticleDetailUIState {}

final class ArticleDetailPresenter: ArticleDetailPresentation {
    private let router: any ArticleDetailWireframe
    private let enviroment: Enviroment
    
    @Published private(set) var uiState: ArticleDetailUIState
    
    init(router: some ArticleDetailWireframe, enviroment: Enviroment) {
        self.router = router
        self.enviroment = enviroment
        self.uiState = ArticleDetailUIState()
    }
}
