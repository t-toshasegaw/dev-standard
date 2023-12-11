//
//  QiitaArticleListGetRequest.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import APIKit
import Foundation

struct QiitaArticleListGetRequest: QiitaRequest {
    typealias Response = [QiitaArticleListResponse]
    
    let method: HTTPMethod = .get
    let path = "items"
    let keyword: String
    
    var queryParameters: [String : Any]? {
        ["query": keyword]
    }
    
    init(keyword: String) {
        self.keyword = keyword
    }
}
