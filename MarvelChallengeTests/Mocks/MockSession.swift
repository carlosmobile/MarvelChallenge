//
//  MockSession.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 11/3/22.
//

import Foundation
@testable import MarvelChallenge

class MockSession: SessionProtocol {

    var dataTask = MockDataTask()
    var expectedData: Data?
    var expectedUrlResponse: URLResponse?
    var expectedError: Error?

    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskProtocol {
        completionHandler(expectedData, expectedUrlResponse, expectedError)
        return dataTask
    }
}

class MockDataTask: DataTaskProtocol {
    func resume() { }
}
