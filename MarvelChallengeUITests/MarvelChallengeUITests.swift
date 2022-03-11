//
//  MarvelChallengeUITests.swift
//  MarvelChallengeUITests
//
//  Created by Carlos Butrón on 9/3/22.
//

import XCTest

class MarvelChallengeUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testScrollOnOfContent() {
        app.tables["characterTable"].swipeUp()
        app.tables["characterTable"].swipeUp()
        app.tables["characterTable"].swipeDown()
        XCTAssert(app.tables.cells.firstMatch.exists)
    }

    func testPullToRefresh() {
        let firstCell = app.tables.children(matching: .cell).element(boundBy: 0)
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 6))
        start.press(forDuration: 0, thenDragTo: finish)
    }

    func testShowSearchBar() {
        app.tables["characterTable"].swipeDown()
        let searchBar = app.searchFields.firstMatch
        XCTAssert(searchBar.exists)
    }

    func testSearchCharactersBySearchBar() {
        app.tables["characterTable"].swipeDown()
        app.searchFields.firstMatch.tap()
        app.searchFields.firstMatch.typeText("Spi")
        sleep(2)
        app.tables["characterTable"].swipeUp()
        app.searchFields.buttons.firstMatch.tap()
    }

    func testShowCharacterDetail() {
        app.tables.cells.firstMatch.tap()
        let cell = app.tables.children(matching: .cell).element(boundBy: 1)
        cell.swipeLeft()
        cell.swipeLeft()
        cell.swipeLeft()
        cell.tap()
        XCTAssertTrue(cell.exists)
    }

    func testShowCharacterDetailComicSeries() {
        app.tables.cells.firstMatch.tap()
        let cell = app.tables.children(matching: .cell).element(boundBy: 1)
        cell.tap()
        XCTAssertTrue(cell.exists)
    }

}
