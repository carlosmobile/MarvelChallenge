//
//  MarvelChallengeLoginUITest.swift
//  MarvelChallengeUITests
//
//  Created by Carlos Butrón on 11/3/22.
//

import XCTest

class MarvelChallengeLoginUITest: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("isUITestingLogin")
        app.launch()
    }

    func testLoginWithBadAPIKeys() {
        let textFieldPublicKey = app.textFields["publicKeyTextField"]
        textFieldPublicKey.tap()
        textFieldPublicKey.typeText("a")
        let textFieldPrivateKey = app.textFields["privateKeyTextField"]
        textFieldPrivateKey.tap()
        textFieldPrivateKey.typeText("a")
        app.buttons["loginButton"].tap()
        sleep(3)
        app.buttons["OK"].tap()
    }

    func testLoginWithGoodAPIKeys() {
        app.buttons["loginButton"].tap()
        sleep(3)
        let textFieldPublicKey = app.textFields["publicKeyTextField"]
        textFieldPublicKey.tap()
        textFieldPublicKey.typeText("e3170744b203f5e2423ef9d66bcc2af5")
        let textFieldPrivateKey = app.textFields["privateKeyTextField"]
        textFieldPrivateKey.tap()
        textFieldPrivateKey.typeText("6feff0e0d806ae203589e945ad913d40b1dc6677")
        app.buttons["loginButton"].tap()
        sleep(3)
        let tablesQuery = app.tables
        let count = tablesQuery.cells.count
        XCTAssert(count > 0)
    }
}
