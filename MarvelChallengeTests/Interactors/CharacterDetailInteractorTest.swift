//
//  CharacterDetailInteractorTest.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 11/3/22.
//

import XCTest
@testable import MarvelChallenge

class CharacterDetailInteractorTest: XCTestCase {

    class MockRouter: CharacterDetailBuilder {
    }

    class MockInterface: CharacterDetailViewController {

    }

    var presenter: CharacterDetailPresenter!
    var characterDetailInteractor: CharacterDetailInteractor!
    let mockRouter = MockRouter()
    var mockInterface: MockInterface?
    var characterDetailWireframe: CharacterDetailWireframe!

    override func setUp() {
        super.setUp()
        presenter = CharacterDetailPresenter()
        mockInterface = MockInterface()
        characterDetailInteractor = CharacterDetailInteractor()
        characterDetailWireframe = CharacterDetailWireframe()
        presenter.wireframe = characterDetailWireframe
        presenter.viewController = mockInterface
        presenter.interactor = characterDetailInteractor
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCharacterDetailRequestOffline() {
        characterDetailInteractor.isConnected = false
        characterDetailInteractor.requestDetailItems(offset: 0, 1, ItemType.Comics)
    }

    func testCharacterDetailRequestOnline() {
        characterDetailInteractor.isConnected = true
        characterDetailInteractor.requestDetailItems(offset: 0, 1, ItemType.Series)
    }
}
