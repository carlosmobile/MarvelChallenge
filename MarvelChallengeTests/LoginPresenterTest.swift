//
//  LoginPresenterTest.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 10/3/22.
//

import XCTest
import RxSwift
import RxCocoa
@testable import MarvelChallenge

class LoginPresenterTest: XCTestCase {

    class MockInterface: LoginAPIViewController {
        var shouldShowError = false

        func showLoadingError(errorMessage: String) {
            shouldShowError = true
        }
    }

    class MockInteractor: LoginAPIInteractor {
        override func requestCharacters() {
        }
    }

    class MockWireframe: LoginAPIWireframe {
        override func pushCharacterList(_ characterDataContainer: CharacterDataContainer) {
        }
    }

    struct LoginAPIViewModel {
        let characterDataContainer = BehaviorRelay<CharacterDataContainer?>(value: nil)
    }

    var presenter: LoginAPIPresenter?
    var mockInterface: MockInterface?
    var mockWireframe: MockWireframe?
    var mockInteractor: MockInteractor?
    var viewModel = LoginAPIViewModel()

    override func setUp() {
        super.setUp()
        presenter = LoginAPIPresenter()
        mockInterface = MockInterface()
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
        viewModel.characterDataContainer.accept(nil)
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
