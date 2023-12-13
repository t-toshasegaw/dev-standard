//
//  LecacyViewController.swift
//  DevStandard
//
//  Created by 長谷川稔樹 on 2023/12/06.
//

import DomainModel
import UIKit

final class ArticleDetailViewController: UIViewController {
    private let article: ArticleModel
    
    @IBOutlet private weak var textLabel: UILabel!
    
    init(article: ArticleModel) {
        self.article = article
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = article.title
    }
}
