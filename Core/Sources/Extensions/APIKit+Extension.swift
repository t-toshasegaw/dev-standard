//
//  APIKit+Extension.swift
//  
//
//  Created by 長谷川稔樹 on 2023/09/16.
//

import APIKit
import Foundation

public extension Request where Response: Decodable {
    var dataParser: DataParser {
        OriginalJsonDataParser()
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        guard (200 ..< 300).contains(urlResponse.statusCode) else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }

        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode(Response.self, from: data)
    }
}

private struct OriginalJsonDataParser: DataParser {
    var contentType: String? = "application/json"

    func parse(data: Data) throws -> Any {
        data
    }
}
