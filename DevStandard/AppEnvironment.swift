//
//  AppEnvironment.swift
//  DevStandard
//
//  Created by 長谷川稔樹 on 2023/12/10.
//

import Article
import Environment
import Infra
import Usecase

final class AppEnvironment: Environment {
    func resolve<Descriptor: TypedDescriptor>(_ descriptor: Descriptor) -> Descriptor.Output {
        switch descriptor {
        case let descriptor as ViewDescriptor.ArticleListDescriptor:
            return ArticleListRouter.assembleModules(
                with: descriptor,
                environment: self
            ) as! Descriptor.Output
            
        case let descriptor as ViewDescriptor.ArticleDetailDescriptor:
            return ArticleDetailRouter.assembleModules(
                with: descriptor,
                environment: self
            ) as! Descriptor.Output
            
        default:
            fatalError("descriptor cases are not covered")
        }
    }
}

extension AppEnvironment {
    private enum DataStoreInstance {
        static let qiitaDataStore = QiitaDataStore()
    }
    
    var articleListGetInteractor: any ArticleListGetUseCase {
        ArticleListGetInteractor(qiitaDataStore: DataStoreInstance.qiitaDataStore)
    }
}
