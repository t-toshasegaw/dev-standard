//
//  ArticleDetailView.swift
//  
//
//  Created by 長谷川稔樹 on 2023/10/08.
//

import DomainModel
import SwiftUI

protocol ArticleDetailViewDelegate: AnyObject {
}

struct ArticleDetailView<Presenter: ArticleDetailPresentation>: View {
    @StateObject var presenter: Presenter
    weak var delegate: ArticleDetailViewDelegate?
    
    var body: some View {
        Text(presenter.uiState.article.title)
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        class Presenter: ArticleDetailPresentation {
            var uiState: ArticleDetailUiState {
                let article: ArticleModel = .init(
                    id: "1",
                    title: "タイトル",
                    url: URL(string: "https://hogehoge.com")!
                )
                
                return .init(article: article)
            }
        }
        
        return ArticleDetailView(presenter: Presenter())
    }
}
