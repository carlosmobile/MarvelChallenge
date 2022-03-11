//
//  TestsMarvelImage.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 11/3/22.
//

import XCTest
@testable import MarvelChallenge

class TestsMarvelImage: XCTestCase {

    func testDownloadImageWithThirdPartyLibrary() throws {

        let testImage = UIImage.init(named: "test.jpg", in: Bundle.init(for: TestsMarvelImage.self), compatibleWith: nil)!

        let portraitImage = UIImageView()
        let standardImage = UIImageView()
        let fullImage = UIImageView()

        var portraitImageURL: String = ""
        var standardImageURL: String = ""
        var fullImageURL: String = ""

        let json = MarvelImageJSON
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        do {
            let thumbnail = try JSONDecoder().decode(MarvelImage.self, from: data)
            portraitImageURL = thumbnail.path + "/portrait_uncanny" + "." + thumbnail.imageExtension
            standardImageURL = thumbnail.path + "/standard_fantastic" + "." + thumbnail.imageExtension
            fullImageURL = thumbnail.path + "." + thumbnail.imageExtension
        } catch {
            XCTAssert(false)
        }

        portraitImage.image = testImage
        standardImage.image = testImage
        fullImage.image = testImage

        let portraitImageDownloaded = downloadImageWithThirdPartyLibrary(imageView: portraitImage,
                                                                         url: URL(string: portraitImageURL)!)
        let standardImageDownloaded = downloadImageWithThirdPartyLibrary(imageView: standardImage,
                                                                         url: URL(string: standardImageURL)!)
        let fullImageDownloaded = downloadImageWithThirdPartyLibrary(imageView: fullImage,
                                                                     url: URL(string: fullImageURL)!)

        XCTAssertNotNil(portraitImageDownloaded.image?.size)
        XCTAssertNotNil(standardImageDownloaded.image?.size)
        XCTAssertNotNil(fullImageDownloaded.image?.size)
        XCTAssertEqual(CGSize(width: 300.0, height: 450.0), portraitImageDownloaded.image?.size)
        XCTAssertEqual(CGSize(width: 250.0, height: 250.0), standardImageDownloaded.image?.size)
        XCTAssertEqual(CGSize(width: 850.0, height: 850.0), fullImageDownloaded.image?.size)
    }

    private func downloadImageWithThirdPartyLibrary(imageView: UIImageView, url: URL) -> UIImageView {

        let keysExpectation = expectation(description: "Keys")

        imageView.kf.setImage(
            with: url,
            options: [
                .transition(.none),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success( _):
                keysExpectation.fulfill()
            case .failure( _):
                XCTAssert(false)
            }
        }

        self.waitForExpectations(timeout: 5, handler: nil)

        return imageView
    }
}
