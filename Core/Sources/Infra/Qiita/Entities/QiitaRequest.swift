//
//  QiitaRequest.swift
//
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import APIKit
import Extension
import Foundation

protocol QiitaRequest: Request {}

extension QiitaRequest {
    var baseURL: URL {
        URL(string: "https://qiita.com/api/v2/")!
    }
}
