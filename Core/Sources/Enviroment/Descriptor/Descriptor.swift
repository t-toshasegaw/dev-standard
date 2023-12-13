//
//  Descriptor.swift
//
//
//  Created by 長谷川稔樹 on 2023/12/06.
//

import DomainModel
import UIKit

public enum ViewDescriptor {}

extension ViewDescriptor {
    public struct ArticleListDescriptor: TypedDescriptor {
        public typealias Output = UIViewController
        
        public init() {}
    }
}

extension ViewDescriptor {
    public struct ArticleDetailDescriptor: TypedDescriptor {
        public typealias Output = UIViewController
        public let article: ArticleModel
        
        public init(article: ArticleModel) {
            self.article = article
        }
    }
}
