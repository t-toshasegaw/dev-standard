//
//  Environment.swift
//
//
//  Created by 長谷川稔樹 on 2023/12/06.
//

import Usecase

public protocol Environment {
    var articleListGetInteractor: any ArticleListGetUseCase { get }
    
    @MainActor
    func resolve<Descriptor: TypedDescriptor>(_ descriptor: Descriptor) -> Descriptor.Output
}
