//
//  APIError.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailure
    case noInternet
}

