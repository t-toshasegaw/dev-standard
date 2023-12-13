//
//  LecacyRouter.swift
//  DevStandard
//
//  Created by 長谷川稔樹 on 2023/12/06.
//

import DomainModel
import Enviroment
import RouterProtocol
import UIKit

enum ArticleDetailDestination {
    case articleDetail(ArticleModel)
}

protocol ArticleDetailWireframe: Wireframe where Destination == ArticleDetailDestination {}

final class ArticleDetailRouter: ArticleDetailWireframe {
    private unowned let viewController: UIViewController
    let enviroment: Enviroment
    
    init(viewController: UIViewController, enviroment: Enviroment) {
        self.viewController = viewController
        self.enviroment = enviroment
    }
    
    static func assembleModules(
        with descriptor: ViewDescriptor.ArticleDetailDescriptor,
        enviroment: Enviroment
    ) -> UIViewController {
        let view = ArticleDetailViewController(article: descriptor.article)
        let router = ArticleDetailRouter(viewController: view, enviroment: enviroment)
        let presenter = ArticleDetailPresenter(router: router, enviroment: enviroment)
        
        view.presenter = presenter
        
        return view
    }
}

extension ArticleDetailRouter {
    func navigation(to destination: ArticleDetailDestination) {
    }
}
