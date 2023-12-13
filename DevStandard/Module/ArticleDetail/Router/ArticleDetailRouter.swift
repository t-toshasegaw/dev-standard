//
//  LecacyRouter.swift
//  DevStandard
//
//  Created by 長谷川稔樹 on 2023/12/06.
//

import DomainModel
import Enviroment
import UIKit

final class ArticleDetailRouter {
    let enviroment: Enviroment
    
    init(enviroment: Enviroment) {
        self.enviroment = enviroment
    }
    
    static func assembleModules(
        with descriptor: ViewDescriptor.ArticleDetailDescriptor,
        enviroment: Enviroment
    ) -> UIViewController {
        let view = ArticleDetailViewController(article: descriptor.article)
        return view
    }
}
