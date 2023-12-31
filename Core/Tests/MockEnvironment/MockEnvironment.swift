//
//  MockEnvironment.swift
//
//
//  Created by 長谷川稔樹 on 2023/12/25.
//

import Environment
import Usecase

final class MockEnvironment: Environment {
    lazy var articleListGetInteractor: any ArticleListGetUseCase = MockArticleListGetInteractor()
    
    func resolve<Descriptor: TypedDescriptor>(_ descriptor: Descriptor) -> Descriptor.Output {
        fatalError("do not ues `resolve` when testing")
    }
}
