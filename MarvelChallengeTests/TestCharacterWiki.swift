//
//  TestCharacterWiki.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 11/3/22.
//

import XCTest
import WebKit
@testable import MarvelChallenge

class TestCharacterWiki: XCTestCase {

    var sut: CharacterWikiViewController!

    override func setUpWithError() throws {
        sut = CharacterWikiViewController()
    }
    override func tearDownWithError() throws {
        sut = nil
    }

    func testCharacterWiki() throws {
        sut.configureActivityIndicator()
        sut.closeAction(UIButton())
    }
}
