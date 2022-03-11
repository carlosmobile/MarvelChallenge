//
//  TestModels.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 11/3/22.
//

import XCTest
@testable import MarvelChallenge

class TestModels: XCTestCase {

    func testMarvelCharacterDataWrapperDecoding() throws {

        let json = CharacterDataWrapperJSON
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        do {
            let characterDataWrapper = try JSONDecoder().decode(CharacterDataWrapper.self, from: data)
            XCTAssertEqual(characterDataWrapper.code, 200)
            XCTAssertEqual(characterDataWrapper.status, "Ok")
            XCTAssertNotNil(characterDataWrapper.data)
        } catch {
            XCTAssert(false)
        }
    }

    func testMarvelCharacterDataContainerDecoding() throws {

        let json = CharacterDataContainerJSON
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        do {
            let characterDataContainer = try JSONDecoder().decode(CharacterDataContainer.self, from: data)
            XCTAssertEqual(characterDataContainer.offset, 0)
            XCTAssertEqual(characterDataContainer.total, 1493)
            XCTAssertNotNil(characterDataContainer.results)
        } catch {
            XCTAssert(false)
        }
    }

    func testMarvelCharacterDecoding() throws {

        let json = CharacterJSON
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        do {
            let character = try JSONDecoder().decode(Character.self, from: data)
            XCTAssertEqual(character.id, 1011334)
            XCTAssertEqual(character.name, "3-D Man")
            XCTAssertNotNil(character.description)
            XCTAssertNotNil(character.urls)
            XCTAssertNotNil(character.thumbnail)
            XCTAssertNotNil(character.comicsTotal)
            XCTAssertNotNil(character.seriesTotal)
        } catch {
            XCTAssert(false)
        }
    }

    func testMarvelUrlDecoding() throws {

        let json = MarvelUrlJSON
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        do {
            let marvelUrl = try JSONDecoder().decode(MarvelUrl.self, from: data)
            XCTAssertEqual(marvelUrl.type, "detail")
            XCTAssertEqual(marvelUrl.url, "http://marvel.com/universe/3-D_Man_(Chandler)?utm_campaign=apiRef&utm_source=0a2dd4c8bd45e7ce7dc086c8ac34760b")
        } catch {
            XCTAssert(false)
        }
    }

    func testMarvelItemDataWrapperDecoding() throws {

        let json = ItemDataWrapperJSON
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        do {
            let itemDataWrapper = try JSONDecoder().decode(ItemDataWrapper.self, from: data)
            XCTAssertEqual(itemDataWrapper.code, 200)
            XCTAssertEqual(itemDataWrapper.status, "Ok")
            XCTAssertNotNil(itemDataWrapper.data)
        } catch {
            XCTAssert(false)
        }
    }

    func testMarvelItemDataContainerDecoding() throws {

        let json = ItemDataContainerJSON
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        do {
            let itemDataContainer = try JSONDecoder().decode(ItemDataContainer.self, from: data)
            XCTAssertEqual(itemDataContainer.offset, 0)
            XCTAssertNotNil(itemDataContainer.results)
            XCTAssertEqual(itemDataContainer.total, 3)
            XCTAssertNotNil(itemDataContainer.formatType)
        } catch {
            XCTAssert(false)
        }
    }

    func testMarvelItemDecoding() throws {

        let json = ItemJSON
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        do {
            let item = try JSONDecoder().decode(Item.self, from: data)
            XCTAssertEqual(item.id, 1945)
            XCTAssertEqual(item.title, "Avengers: The Initiative (2007 - 2010)")
            XCTAssertEqual(item.description, "")
            XCTAssertNotNil(item.thumbnail)
            XCTAssertNotNil(item.formatDescription)
        } catch {
            XCTAssert(false)
        }
    }

    func testMarvelImageDecoding() throws {

        let json = MarvelImageJSON
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        do {
            let thumbnail = try JSONDecoder().decode(MarvelImage.self, from: data)
            XCTAssertEqual(thumbnail.path, "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784")
            XCTAssertEqual(thumbnail.imageExtension, "jpg")
        } catch {
            XCTAssert(false)
        }
    }

}

