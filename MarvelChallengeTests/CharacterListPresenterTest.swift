//
//  CharacterListPresenterTest.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 11/3/22.
//

import XCTest
@testable import MarvelChallenge

class CharacterListPresenterTest: XCTestCase {

    class MockInterface: CharacterListViewController {
        override func updateCharacterListViewWithAlert(_ message: String, _ errorType: APIError) {

        }

        override func updateCharacterListView() {

        }
    }

    class MockInteractor: CharacterListInteractor {
        override func requestCharacters(_ from: Int?, _ nameStartsWith: String) {

        }
    }

    class MockWireframe: CharacterListWireframe {
        override func pushCharacterDetail(_ character: Character) {

        }
    }

    var presenter: CharacterListPresenter?
    var mockInterface: MockInterface?
    var mockWireframe: MockWireframe?
    var mockInteractor: MockInteractor?

    override func setUp() {
        super.setUp()
        presenter = CharacterListPresenter()
        mockInterface = MockInterface()
        mockWireframe = MockWireframe()
        mockInteractor = MockInteractor()
        presenter?.wireframe = mockWireframe
        presenter?.interactor = mockInteractor
    }

    override func tearDown() {
        super.tearDown()
    }

    func testHandleRequestData() {
        presenter?.handleRequestData(from: 0, nameStartsWith: "a", requestType: RequestType.characterRegular)
    }

    func testHandleItemSelected() {
        let json = CharacterJSON
        if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            let character = try? JSONDecoder().decode(Character.self, from: data)
            presenter?.handleItemSelected(character: character!)
        }
    }

    func testCharacterRequestDidFinish() {
        presenter?.characterRequestDidFinish()
    }

    func testCharacterRequestError() {
        presenter?.characterRequestError(message: "", errorType: APIError.decodingFailure)
    }

    func testCharacterRequestDataRegular() {
        let json = CharacterDataContainerJSON
        if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            let characterDataContainer = try? JSONDecoder().decode(CharacterDataContainer.self, from: data)
            presenter?.characterRequestDataRegular(response: characterDataContainer!)
        }
    }

    func testCharacterRequestDataSearchFilter() {
        let json = CharacterDataContainerJSON
        if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            let characterDataContainer = try? JSONDecoder().decode(CharacterDataContainer.self, from: data)
            presenter?.characterRequestDataSearchFilter(response: characterDataContainer!)
        }
    }
}
