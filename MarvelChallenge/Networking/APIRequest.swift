//
//  APIRequest.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import Foundation

class APIRequest {
    let method: HTTPMethod
    let path: String
    var queryItems: [URLQueryItem]?
    var headers: [HTTPHeader]?
    var body: Data?

    init(method: HTTPMethod, path: String) {
        self.method = method
        self.path = path
        let keys = APIKeys.requestMarvelKeys().self
        self.queryItems = [
            URLQueryItem(name: "ts", value: String(keys.timestamp)),
            URLQueryItem(name: "apikey", value: keys.apikey),
            URLQueryItem(name: "hash", value: keys.hash)
        ]
    }
}
