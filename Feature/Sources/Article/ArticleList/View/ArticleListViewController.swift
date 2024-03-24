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
        
        addSwiftUIChild(ArticleListView(presenter: presenter ,delegate: self))
        
        Task { [presenter] in
            await presenter?.getArticleList(of: "swift")
        }
        .store(in: &cancellables)
    }
}

extension ArticleListViewController: ArticleListViewDelegate {
    func didSelect(of article: ArticleModel) {
        Task { [presenter] in
            await presenter?.didSelect(of: article)
        }
        .store(in: &cancellables)
    }
    
    func onErrorAlertDismiss() {
        Task { [presenter] in
            await presenter?.onErrorAlertDismiss()
        }
        .store(in: &cancellables)
    }
}

extension ArticleListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let keyword = searchBar.text else { return }
        
        Task { [presenter] in
            await presenter?.getArticleList(of: keyword)
        }
        .store(in: &cancellables)
    }
}
