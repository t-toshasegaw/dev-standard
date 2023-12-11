//
//  RepositoryDependencyValues.swift
//  
//
//  Created by 長谷川稔樹 on 2023/12/06.
//

import Dependencies
import Foundation
import Infra
import Repository

public extension DependencyValues {
    private enum QiitaRepositoryKey: DependencyKey {
        static let liveValue: any QiitaRepository = QiitaDataStore()
        static var testValue: any QiitaRepository = unimplemented()
    }
    var qiitaDataStore: any QiitaRepository {
        get { self[QiitaRepositoryKey.self] }
        set { self[QiitaRepositoryKey.self] = newValue }
    }
}
