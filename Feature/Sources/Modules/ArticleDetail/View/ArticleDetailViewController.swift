//
//  ArticleDetailViewController.swift
//
//
//  Created by 長谷川稔樹 on 2023/10/08.
//

import Combine
import Extension
import UIKit

final class ArticleDetailViewController: UIViewController {
    var presenter: ArticleDetailPresenter!
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSwiftUIChild(ArticleDetailView(presenter: self.presenter, delegate: self))
    }
}

extension ArticleDetailViewController: ArticleDetailViewDelegate {
}
