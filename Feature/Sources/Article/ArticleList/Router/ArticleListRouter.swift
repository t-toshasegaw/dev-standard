//
//  ArticleListRouter.swift
//  
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import Environment
import DomainModel
import RouterProtocol
import UIKit

public enum ArticleListDestination {
    case articleDetail(ArticleModel)
}

protocol ArticleListWireframe: Wireframe where Destination == ArticleListDestination {}

public final class ArticleListRouter: ArticleListWireframe {
    private unowned let viewController: UIViewController
    private let environment: Environment
    
    private init(viewController: UIViewController, environment: Environment) {
        self.viewController = viewController
        self.environment = environment
    }
    
    public static func assembleModules(
        with descriptor: ViewDescriptor.ArticleListDescriptor,
        environment: Environment
    ) -> UIViewController {
        let view = ArticleListViewController()
        let router = ArticleListRouter(viewController: view, environment: environment)
        let presenter = ArticleListPresenter(router: router, environment: environment)
        
        view.presenter = presenter
        
        return view
    }
}

extension ArticleListRouter {
    public func navigation(to destination: ArticleListDestination) {
        var view: UIViewController {
            return switch destination {
            case .articleDetail(let article):
                environment.resolve(ViewDescriptor.ArticleDetailDescriptor(article: article))
            }
        }
        viewController.navigationController?.pushViewController(view, animated: true)
    }
}
