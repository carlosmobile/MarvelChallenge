//
//  TestVIPERWireframes.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 11/3/22.
//

import XCTest
@testable import MarvelChallenge

class TestVIPERWireframe: XCTestCase {

    var loginAPIWireFrame: LoginAPIWireframe!
    var characterListWireframe: CharacterListWireframe!
    var characterDetailWireframe: CharacterDetailWireframe!

    override func tearDownWithError() throws {
        loginAPIWireFrame = nil
        characterListWireframe = nil
        characterDetailWireframe = nil
    }

    func testOTPWireframe() throws {
        loginAPIWireFrame = LoginAPIWireframe()
        let jsonContainer = CharacterDataContainerJSON
        if let data = try? JSONSerialization.data(withJSONObject: jsonContainer, options: .prettyPrinted) {
            let characterDataContainer = try? JSONDecoder().decode(CharacterDataContainer.self, from: data)
            loginAPIWireFrame.pushCharacterList(characterDataContainer!)
        }

        characterListWireframe = CharacterListWireframe()
        let jsonCharacter = CharacterJSON
        if let data = try? JSONSerialization.data(withJSONObject: jsonCharacter, options: .prettyPrinted) {
            let character = try? JSONDecoder().decode(Character.self, from: data)
            characterListWireframe.pushCharacterDetail(character!)
        }

        characterDetailWireframe = CharacterDetailWireframe()
        let jsonItem = ItemJSON
        if let data = try? JSONSerialization.data(withJSONObject: jsonItem, options: .prettyPrinted) {
            let item = try? JSONDecoder().decode(Item.self, from: data)
            characterDetailWireframe.presenterExtendedDetail(item!)
        }
        characterDetailWireframe.presenterCharacterWiki("")
    }
}
