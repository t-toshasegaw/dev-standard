//
//  ArticleListViewController.swift
//  
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import Combine
import DomainModel
import Extension
import UIKit

final class ArticleListViewController: UIViewController {
    var presenter: ArticleListPresenter!
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = self
        searchBar.placeholder = "キーワードで検索"
        
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "記事一覧"
        navigationItem.titleView = searchBar
        
        addSwiftUIChild(ArticleListView(presenter: self.presenter ,delegate: self))
        
        Task {
            await presenter.getArticleList(of: "swift")
        }
        
        // エラー処理
        errorHandling()
    }
}

extension ArticleListViewController {
    private func errorHandling() {
        presenter.$articleListError
            .compactMap { $0 }
            .map { articleListError -> (title: String, message: String) in
                return switch articleListError {
                case .articleListGetError(let error):
                    switch error {
                    case .connectionError:
                        ("connectionError", "ネットワーク環境を確認してください")
                        
                    case .requestError:
                        ("requestError", "")
                        
                    case .responseError:
                        ("responseError", "")
                        
                    case .logicFailure:
                        ("logicFailure", "")
                    }
                }
            }
            .sink { [weak self] title, message in
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                alert.addAction(action)
                
                self?.present(alert, animated: true)
            }
            .store(in: &cancellables)
    }
}

extension ArticleListViewController: ArticleListViewDelegate {
    func didSelect(of article: ArticleModel) {
        presenter.didSelect(of: article)
    }
}

extension ArticleListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let keyword = searchBar.text else { return }
        
        Task {
            await presenter.getArticleList(of: keyword)
        }
    }
}
