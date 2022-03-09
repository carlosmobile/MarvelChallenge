//
//  APIConfiguration.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import Foundation

struct Server {
    static let baseURL = "https://gateway.marvel.com:443/v1/public"
    static var charactersEndpointURL: String {
        return Server.baseURL + "/characters"
    }
    static let comicsEndpointURL = "/comics"
    static let seriesEndpointURL = "/series"

    static let termsURL = "https://gateway.marvel.com:443/v1/public"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct HTTPHeader {
    let field: String
    let value: String
}
