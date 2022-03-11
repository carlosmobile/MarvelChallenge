//
//  MarvelChallengeUITestsLaunchTests.swift
//  MarvelChallengeUITests
//
//  Created by Carlos Butrón on 9/3/22.
//

import XCTest

class MarvelChallengeUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        false
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
    }
}
