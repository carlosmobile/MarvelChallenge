//
//  TestExtensions.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 11/3/22.
//

import XCTest
@testable import MarvelChallenge

class TestExtensions: XCTestCase {

    func testUIViewController() throws {
        let testViewController = UIViewController()
        testViewController.showCustomAlertWith(okButtonAction: {

        }, title: "", message: "")
    }

    func testNetworkAlert() throws {
        let alert = UIViewController()
        Alert.present("test network alert", actions: [.ok(handler: {
            let isAlertPresent = true
            XCTAssertEqual(isAlertPresent, true)
        })], from: alert)
    }

    func testThemeManager() throws {
        let color = ThemeColor.default.MVColor
        let image = ThemeImage.default.MVImage
        XCTAssertNotNil(color, "color theme failed")
        XCTAssertNotNil(image, "image theme failed")
    }
}
