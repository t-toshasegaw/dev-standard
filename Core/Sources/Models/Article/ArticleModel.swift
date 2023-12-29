//
//  ArticleModel.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import Foundation

public struct ArticleModel: Identifiable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let url: URL
    
    public init(
        id: String,
        title: String,
        url: URL
    ) {
        self.id = id
        self.title = title
        self.url = url
    }
}
