//
//  MarvelImage.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import Foundation

struct MarvelImage: Codable {
    var path: String
    var imageExtension: String
    var portraitMedium: String {
        path + "/portrait_uncanny" + "." + imageExtension
    }
    var standardMedium: String {
        path + "/standard_fantastic" + "." + imageExtension
    }
    var fullSize: String {
        path + "." + imageExtension
    }
}

extension MarvelImage {
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
