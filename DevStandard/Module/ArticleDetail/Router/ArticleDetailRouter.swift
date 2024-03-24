//
//  LecacyRouter.swift
//  DevStandard
//
//  Created by 長谷川稔樹 on 2023/12/06.
//

import DomainModel
import Environment
import RouterProtocol
import UIKit

enum ArticleDetailDestination {
    case articleDetail(ArticleModel)
}

protocol ArticleDetailWireframe: Wireframe where Destination == ArticleDetailDestination {}

final class ArticleDetailRouter: ArticleDetailWireframe {
    private unowned let viewController: UIViewController
    private let environment: any Environment
    
    init(viewController: UIViewController, environment: some Environment) {
        self.viewController = viewController
        self.environment = environment
    }
    
    static func assembleModules(
        with descriptor: ViewDescriptor.ArticleDetailDescriptor,
        environment: some Environment
    ) -> UIViewController {
        let view = ArticleDetailViewController(article: descriptor.article)
        let router = ArticleDetailRouter(viewController: view, environment: environment)
        let presenter = ArticleDetailPresenter(router: router, environment: environment)
        
        view.presenter = presenter
        
        return view
    }
}

extension ArticleDetailRouter {
    func navigation(to destination: ArticleDetailDestination) {
    }
}
