//
//  CharacterListPresenterTest.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 10/3/22.
//

import XCTest
@testable import MarvelChallenge

class CharacterDetailPresenterTest: XCTestCase {

    class MockInterface: CharacterDetailViewController {
        override func updateCharacterDetailViewWithAlert(_ message: String, _ errorType: APIError) {

        }
        override func updateItemsView(type: ItemType) {
            
        }
    }

    class MockInteractor: CharacterDetailInteractor {
        override func requestDetailItems(offset: Int, _ id: Int, _ type: ItemType) {

        }
    }

    class MockWireframe: CharacterDetailWireframe {
        override func presenterCharacterWiki(_ wikiURL: String) {

        }
        override func presenterExtenderDetail(_ extendedDetail: Item) {

        }
    }

    var presenter: CharacterDetailPresenter?
    var mockInterface: MockInterface?
    var mockWireframe: MockWireframe?
    var mockInteractor: MockInteractor?

    override func setUp() {
        super.setUp()
        presenter = CharacterDetailPresenter()
        mockInterface = MockInterface()
        mockWireframe = MockWireframe()
        mockInteractor = MockInteractor()
        presenter?.wireframe = mockWireframe
        presenter?.interactor = mockInteractor
    }

    override func tearDown() {
        super.tearDown()
    }

    func testHandleViewUpdateITems() {
        presenter?.handleViewUpdateITems(offset: 0, type: ItemType.Comics)
    }

    func testHandleItemSelected() {
        let json = ItemJSON
        if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            let item = try? JSONDecoder().decode(Item.self, from: data)
            presenter?.handleItemSelected(extendedDetail: item!)
        }
    }

    func testHandleWikiSelected() {
        presenter?.handleWikiSelected("")
    }

    func testCharacterDetailRequestDidFinish() {
        presenter?.characterDetailRequestDidFinish()
    }

    func testCharacterDetailRequestError() {
        presenter?.characterDetailRequestError(message: "", errorType: APIError.requestFailed)
    }

    func testCharacterItemsRequestData() {
        let json = ItemDataContainerJSON
        if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            let itemDataContainer = try? JSONDecoder().decode(ItemDataContainer.self, from: data)
            presenter?.characterItemsRequestData(response: itemDataContainer!)
        }
    }

}
