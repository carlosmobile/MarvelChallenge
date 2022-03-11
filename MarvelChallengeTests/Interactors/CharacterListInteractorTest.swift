//
//  CharacterListInteractorTest.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 11/3/22.
//

import XCTest
@testable import MarvelChallenge

class CharacterListInteractorTest: XCTestCase {

    class MockRouter: CharacterListBuilder {
    }

    class MockInterface: CharacterListViewController {

    }

    var presenter: CharacterListPresenter!
    var characterListInteractor: CharacterListInteractor!
    let mockRouter = MockRouter()
    var mockInterface: MockInterface?
    var characterListWireframe: CharacterListWireframe!

    override func setUp() {
        super.setUp()
        presenter = CharacterListPresenter()
        mockInterface = MockInterface()
        characterListInteractor = CharacterListInteractor()
        characterListWireframe = CharacterListWireframe()
        presenter.wireframe = characterListWireframe
        presenter.viewController = mockInterface
        presenter.interactor = characterListInteractor
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCharacterListRequestOffline() {
        characterListInteractor.isConnected = false
        characterListInteractor.requestCharacters(0, "a")
    }

    func testCharacterListRequestOnline() {
        characterListInteractor.isConnected = true
        characterListInteractor.requestCharacters(0, "a")
    }
}
