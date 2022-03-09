//
//  CharacterItems.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import Foundation

struct ItemDataWrapper: Codable {
    let code: Int
    let status: String
    let data: ItemDataContainer
}

struct ItemDataContainer: Codable {
    let offset: Int
    let total: Int
    var type: ItemType?
    let results: [Item]

    var formatType: ItemType {
        if type == nil {
            return ItemType.Error
        } else {
            return type!
        }
    }
}

struct Item: Codable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: MarvelImage

    var formatDescription: String {
        if description == nil || description == "" {
            return "noDescription".localized
        } else {
            return description!
        }
    }
}

enum ItemType: Int, Codable {
    case Comics
    case Series
    case Error

    func pathType() -> String {
        switch self {
        case .Comics:
            return Server.comicsEndpointURL
        case .Series:
            return Server.seriesEndpointURL
        case .Error:
            return "error".localized
        }
    }

    func title() -> String {
        switch self {
        case .Comics:
            return "Comics"
        case .Series:
            return "Series"
        case .Error:
            return "error".localized
        }
    }
}

