//
//  APIClient.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import Foundation

enum APIResult<Body> {
    case success(APIResponse<Body>)
    case failure(APIError)
}

typealias APIClientCompletion = (APIResult<Data?>) -> Void

protocol APIClientProtocol {
    func perform(
        request: APIRequest,
        completion: @escaping APIClientCompletion
    )
}

class APIClient {

    private let session: SessionProtocol

    // MARK: - Lifecycle

    convenience init() {
        self.init(session: URLSession.shared)
    }

    init(session: SessionProtocol) {
        self.session = session
    }

    func perform(
        request: APIRequest,
        completion: @escaping APIClientCompletion) {

        let baseURL = URL(string: request.path)!
        var urlComponents = URLComponents()
        urlComponents.scheme = baseURL.scheme
        urlComponents.host = baseURL.host
        urlComponents.path = baseURL.path
        urlComponents.queryItems = request.queryItems

        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }

        #if DEBUG
            print(url)
        #endif

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            guard let data = data else { return }
            if let jsonResponse = (try? JSONSerialization.jsonObject(with: data, options: [])) as? NSDictionary {
                #if DEBUG
                print(jsonResponse)
                #endif
            }
            completion(.success(APIResponse<Data?>(statusCode: httpResponse.statusCode, body: data)))
        }
        task.resume()
    }
}

