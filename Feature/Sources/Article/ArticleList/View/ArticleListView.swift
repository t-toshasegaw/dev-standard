//
//  ArticleListView.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/17.
//

import DomainModel
import SwiftUI

protocol ArticleListViewDelegate: AnyObject {
    func didSelect(of article: ArticleModel)
}

struct ArticleListView<Presenter: ArticleListPresentation>: View {
    @StateObject var presenter: Presenter
    weak var delegate: ArticleListViewDelegate?
    
    var body: some View {
        ZStack(alignment: .center) {
            List(presenter.uiState.articleList) { article in
                Button {
                    delegate?.didSelect(of: article)
                } label: {
                    HStack {
                        Text(article.title)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
                .foregroundStyle(.black)
            }
            
            if presenter.uiState.isDisplayProgressView {
                ProgressView()
            }
        }
        .animation(.default, value: presenter.uiState.articleList)
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        class Presenter: ArticleListPresentation {
            var uiState: ArticleListUIState {
                let dummyUrl = URL(string: "https://hogehoge.com")!
                let articleList: [ArticleModel] = [
                    .init(
                        id: "1",
                        title: "タイトル", 
                        url: dummyUrl
                    ),
                    .init(
                        id: "2",
                        title: "タイトルタイトルタイトルタイトルタイトルタイトル",
                        url: dummyUrl
                    )
                ]
                
                return .init(articleList: articleList)
            }
        }
        
        return ArticleListView(presenter: Presenter())
    }
}