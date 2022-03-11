//
//  LoginInteractorTest.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 11/3/22.
//

import XCTest
@testable import MarvelChallenge

class LoginInteractorTest: XCTestCase {

    class MockRouter: LoginAPIBuilder {
    }

    class MockInterface: LoginAPIViewController {

    }

    var presenter: LoginAPIPresenter!
    var loginAPIInteractor: LoginAPIInteractor!
    let mockRouter = MockRouter()
    var mockInterface: MockInterface?
    var loginAPIWireframe: LoginAPIWireframe!

    override func setUp() {
        super.setUp()
        presenter = LoginAPIPresenter()
        mockInterface = MockInterface()
        loginAPIInteractor = LoginAPIInteractor()
        loginAPIWireframe = LoginAPIWireframe()
        presenter.wireframe = loginAPIWireframe
        presenter.viewController = mockInterface
        presenter.interactor = loginAPIInteractor
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLoginAPIRequestOffline() {
        loginAPIInteractor.isConnected = false
        loginAPIInteractor.requestCharacters()
    }

    func testLoginAPIRequestOnline() {
        loginAPIInteractor.isConnected = true
        loginAPIInteractor.requestCharacters()
    }
}
