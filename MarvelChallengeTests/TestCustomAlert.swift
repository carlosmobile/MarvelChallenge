//
//  TestCustomAlert.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 11/3/22.
//

import XCTest
@testable import MarvelChallenge

class TestCustomAlert: XCTestCase {

    var sut: CustomAlertViewController!

    override func setUpWithError() throws {
        sut = CustomAlertViewController()
        sut.loadViewIfNeeded()
    }
    override func tearDownWithError() throws {
        sut = nil
    }

    func testCustomAlert() throws {
        sut.viewWillAppear(true)
        let testButton = UIButton()
        sut.okayButtonAction(sender: testButton)
    }
}
