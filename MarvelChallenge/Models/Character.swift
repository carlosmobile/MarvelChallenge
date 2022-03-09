//
//  Character.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import Foundation

struct CharacterDataWrapper: Codable {
    let code: Int
    let status: String
    let data: CharacterDataContainer
}

struct CharacterDataContainer: Codable {
    let offset: Int
    let total: Int
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let description: String
    let urls: [MarvelUrl]
    let thumbnail: MarvelImage
    let comicsTotal: ComicsAvailable
    let seriesTotal: SeriesAvailable

    var formatDescription: String {
        description.isEmpty ? "noDescription".localized : description
    }
    var itemsList: [String: Int] {
        ["Comics" : comicsTotal.available,
         "Series" : seriesTotal.available]
    }
}

extension Character {
    enum CodingKeys: String, CodingKey {
        case id, name, description, urls, thumbnail
        case comicsTotal = "comics"
        case seriesTotal = "series"
    }
}

struct ComicsAvailable: Codable {
    let available: Int
}

struct SeriesAvailable: Codable {
    let available: Int
}
