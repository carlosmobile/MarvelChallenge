//
//  LoginPresenterTest.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 10/3/22.
//

import XCTest
@testable import MarvelChallenge

class LoginPresenterTest: XCTestCase {

    class MockInteractor: LoginAPIInteractor {
        override func requestCharacters() {
        }
    }

    class MockWireframe: LoginAPIWireframe {
        override func pushCharacterList(_ characterDataContainer: CharacterDataContainer) {
        }
    }

    var presenter: LoginAPIPresenter?
    var mockWireframe: MockWireframe?
    var mockInteractor: MockInteractor?

    override func setUp() {
        super.setUp()
        presenter = LoginAPIPresenter()
        mockWireframe = MockWireframe()
        mockInteractor = MockInteractor()
        presenter?.wireframe = mockWireframe
        presenter?.interactor = mockInteractor
    }

    override func tearDown() {
        super.tearDown()
    }

    func testHandleSendAPIKeys() {
        presenter?.handleSendAPIKeys()
    }

    func testHandleSendAPIKeysSuccess() {
        presenter?.handleSendAPIKeysSuccess()
    }

    func testApiRequestDidFinish() {
        presenter?.apiRequestDidFinish()
    }

    func testApiRequestError() {
        presenter?.apiRequestError(message: "", errorType: APIError.noInternet)
    }

    func testApiRequestData() {
        let json = CharacterDataContainerJSON
        if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            let characterDataContainer = try? JSONDecoder().decode(CharacterDataContainer.self, from: data)
            presenter?.apiRequestData(response: characterDataContainer!)
        }
    }
}
