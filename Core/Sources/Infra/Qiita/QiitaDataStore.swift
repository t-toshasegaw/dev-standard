//
//  QiitaDataStore.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import APIKit
import DomainModel
import Foundation
import Repository

public final class QiitaDataStore {
    private let session: Session

    init(session: Session) {
        self.session = session
    }
    
    public convenience init() {
        let adapter = URLSessionAdapter(configuration: .default)
        let session = Session(adapter: adapter, callbackQueue: .sessionQueue)
        self.init(session: session)
    }
}

extension QiitaDataStore: QiitaRepository {
    public func getArticleList(of keyword: String) async throws -> [ArticleModel] {
        do {
            return try await session
                .response(for: QiitaArticleListGetRequest(keyword: keyword))
                .map { try $0.translate() }
        } catch {
            guard let error = error as? SessionTaskError else {
                throw QiitaRepositoryError.logicFailure(error)
            }
            
            switch error {
            case .connectionError(let error):
                throw QiitaRepositoryError.connectionError(error)
                
            case .requestError(let error):
                throw QiitaRepositoryError.requestError(error)
                
            case .responseError(let error):
                throw QiitaRepositoryError.responseError(error)
            }
        }
    }
}
