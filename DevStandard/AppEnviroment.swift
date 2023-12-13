//
//  AppEnviroment.swift
//  DevStandard
//
//  Created by 長谷川稔樹 on 2023/12/10.
//

import Article
import Enviroment
import Infra
import Usecase

final class AppEnviroment: Enviroment {
    var articleListGetError: any ArticleListGetUseCase {
        ArticleListGetInteractor(qiitaDataStore: QiitaDataStore())
    }
    
    func resolve<Descriptor: TypedDescriptor>(_ descriptor: Descriptor) -> Descriptor.Output {
        switch descriptor {
        case let articleListDescriptor as ViewDescriptor.ArticleListDescriptor:
            return ArticleListRouter.assembleModules(with: articleListDescriptor, enviroment: self) as! Descriptor.Output
            
        case let articleDetailDescriptor as ViewDescriptor.ArticleDetailDescriptor:
            return ArticleDetailRouter.assembleModules(with: articleDetailDescriptor, enviroment: self) as! Descriptor.Output
            
        default:
            fatalError()
        }
    }
}
