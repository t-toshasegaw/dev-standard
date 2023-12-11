//
//  ArticleDetailRouter.swift
//
//
//  Created by 長谷川稔樹 on 2023/10/08.
//

import DomainModel
import Enviroment
import RouterProtocol
import UIKit

public enum ArticleDetailDestination: Equatable {
}

public protocol ArticleDetailWireframe: Wireframe where Destination == ArticleDetailDestination {}

public final class ArticleDetailRouter: ArticleDetailWireframe {
    private unowned let viewController: UIViewController
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    public static func assembleModules(
        with descriptor: ViewDescriptor.ArticleDetailDescriptor,
        enviroment: Enviroment
    ) -> UIViewController {
        let view = ArticleDetailViewController()
        let router = ArticleDetailRouter(viewController: view)
        let presenter = ArticleDetailPresenter(router: router, article: descriptor.article)
        
        view.presenter = presenter
        
        return view
    }
}

extension ArticleDetailRouter {
    public func navigation(to destination: ArticleDetailDestination) {
    }
}
