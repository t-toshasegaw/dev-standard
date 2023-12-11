//
//  AppEnviroment.swift
//  DevStandard
//
//  Created by 長谷川稔樹 on 2023/12/10.
//

import Enviroment
import Feature

final class AppEnviroment: Enviroment {
    func resolve<Descriptor: TypedDescriptor>(_ descriptor: Descriptor) -> Descriptor.Output {
        switch descriptor {
        case let articleListDescriptor as ViewDescriptor.ArticleListDescriptor:
            return ArticleListRouter.assembleModules(with: articleListDescriptor, enviroment: self) as! Descriptor.Output
            
        case let articleDetailDescriptor as ViewDescriptor.ArticleDetailDescriptor:
            return ArticleDetailRouter.assembleModules(with: articleDetailDescriptor, enviroment: self) as! Descriptor.Output
            
        case let lecacyDescriptor as ViewDescriptor.LecacyDescriptor:
            return LecacyRouter.assembleModules(with: lecacyDescriptor, enviroment: self) as! Descriptor.Output
            
        default:
            fatalError()
        }
    }
}
