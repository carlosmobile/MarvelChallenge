//
//  TestAutoSearchTimer.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 11/3/22.
//

import XCTest
@testable import MarvelChallenge

class TestAutoSearchTimer: XCTestCase {

    var sut: AutoSearchTimer!

    override func setUpWithError() throws {
        sut = AutoSearchTimer(callback: {
        })
    }
    override func tearDownWithError() throws {
        sut = nil
    }

    func testCustomAlert() throws {
        sut.activate()
        sut.cancel()
    }
}
