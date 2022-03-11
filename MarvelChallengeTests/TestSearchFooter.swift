//
//  TestSearchFooter.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 11/3/22.
//

import XCTest
@testable import MarvelChallenge

class TestSearchFooter: XCTestCase {

    var sut: SearchFooter!

    override func setUpWithError() throws {
        sut = SearchFooter()
    }
    override func tearDownWithError() throws {
        sut = nil
    }

    func testCustomAlert() throws {
        sut.setNotFiltering()
        sut.updateFiltering(filteredItemCount: 0, of: 1)
        sut.setIsFilteringToShow(filteredItemCount: 0, of: 1)
    }
}
