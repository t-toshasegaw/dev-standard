//
//  QiitaArticleListResponse.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import DomainModel
import Foundation

struct QiitaArticleListResponse: Decodable {
    let id: String
    let title: String
    let url: String
}

extension QiitaArticleListResponse {
    func translate() throws -> ArticleModel {
        guard let url = URL(string: url) else {
            throw NSError(domain: "TranslateToQiitaArticleListModelError", code: -1)
        }
        
        return .init(id: id, title: title, url: url)
    }
}
