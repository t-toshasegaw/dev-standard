//
//  ArticleListRouter.swift
//  
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import Enviroment
import DomainModel
import RouterProtocol
import UIKit

public enum ArticleListDestination {
    case articleDetail(ArticleModel)
}

public protocol ArticleListWireframe: Wireframe where Destination == ArticleListDestination {}

public final class ArticleListRouter: ArticleListWireframe {
    private unowned let viewController: UIViewController
    private let enviroment: Enviroment
    
    private init(viewController: UIViewController, enviroment: Enviroment) {
        self.viewController = viewController
        self.enviroment = enviroment
    }
    
    public static func assembleModules(
        with descriptor: ViewDescriptor.ArticleListDescriptor,
        enviroment: Enviroment
    ) -> UIViewController {
        let view = ArticleListViewController()
        let router = ArticleListRouter(viewController: view, enviroment: enviroment)
        let presenter = ArticleListPresenter(router: router, enviroment: enviroment)
        
        view.presenter = presenter
        
        return view
    }
}

extension ArticleListRouter {
    public func navigation(to destination: ArticleListDestination) {
        var view: UIViewController {
            return switch destination {
            case .articleDetail(let article):
                enviroment.resolve(ViewDescriptor.ArticleDetailDescriptor(article: article))
            }
        }
        viewController.navigationController?.pushViewController(view, animated: true)
    }
}
