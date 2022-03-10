//
//  DefaultValues.swift
//  MarvelChallengeTests
//
//  Created by Carlos Butrón on 10/3/22.
//

import XCTest
@testable import MarvelChallenge


// MARK: JSON Object
typealias JSON = [String : Any]

let CharacterDataWrapperJSON: JSON = [
    "code": 200,
    "status": "Ok",
    "copyright": "© 2021 MARVEL",
    "attributionText": "Data provided by Marvel. © 2021 MARVEL",
    "attributionHTML": "<a href=\"http://marvel.com\">Data provided by Marvel. © 2021 MARVEL</a>",
    "etag": "161aa5716f494a881f205f7639405b789fd64917",
    "data": CharacterDataContainerJSON
]

let CharacterDataContainerJSON: JSON = [
    "offset": 0,
    "limit": 1,
    "total": 1493,
    "count": 1,
    "results": [CharacterJSON]
]

let CharacterJSON: JSON = [
    "id": 1011334,
    "name": "3-D Man",
    "description": "",
    "modified": "2014-04-29T14:18:17-0400",
    "thumbnail": MarvelImageJSON,
    "resourceURI": "http://gateway.marvel.com/v1/public/characters/1011334",
    "comics": ComicsAvailableJSON,
    "series": SeriesAvailableJSON,
    "urls": [MarvelUrlJSON]
]

let MarvelImageJSON: JSON = [
    "path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
    "extension": "jpg"
]

let MarvelUrlJSON: JSON = [
    "type": "detail",
    "url": "http://marvel.com/universe/3-D_Man_(Chandler)?utm_campaign=apiRef&utm_source=0a2dd4c8bd45e7ce7dc086c8ac34760b"
]

let ComicsAvailableJSON: JSON = [
    "available": 1
]

let SeriesAvailableJSON: JSON = [
    "available": 1
]

let ItemDataWrapperJSON: JSON = [
    "code": 200,
    "status": "Ok",
    "copyright": "© 2021 MARVEL",
    "attributionText": "Data provided by Marvel. © 2021 MARVEL",
    "attributionHTML": "<a href=\"http://marvel.com\">Data provided by Marvel. © 2021 MARVEL</a>",
    "etag": "a4fd6a6b368e940c9b3ead965c18e594094f0ed6",
    "data": ItemDataContainerJSON
]

let ItemDataContainerJSON: JSON = [
    "offset": 0,
    "total": 3,
    "limit": 20,
    "count": 3,
    "results": [ItemJSON]
]

let ItemJSON: JSON = [
    "id": 1945,
    "title": "Avengers: The Initiative (2007 - 2010)",
    "description": "",
    "thumbnail": MarvelImageJSON
]


// MARK: Cloned Response
let MarvelAPIResponse: JSON = [
    "results": CharacterDataWrapperJSON
]



// MARK: JSON Data

let MarvelAPIRawJSON = """
        {
            "code": 200,
            "status": "Ok",
            "copyright": "© 2020 MARVEL",
            "attributionText": "Data provided by Marvel. © 2020 MARVEL",
            "attributionHTML": "<a href=\"http://marvel.com\">Data provided by Marvel. © 2020 MARVEL</a>",
            "etag": "4eaacae2701b1b2dc665917af2ddf46f7e2ba192",
            "data": {
                "offset": 0,
                "limit": 1,
                "total": 1493,
                "count": 1,
                "results": [{
                    "id": 1011334,
                    "name": "3-D Man",
                    "description": "",
                    "modified": "2014-04-29T14:18:17-0400",
                    "thumbnail": {
                        "path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                        "extension": "jpg"
                    },
                    "resourceURI": "http://gateway.marvel.com/v1/public/characters/1011334",
                    "comics": {
                        "available": 1,
                        "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011334/comics",
                        "items": [{
                            "resourceURI": "http://gateway.marvel.com/v1/public/comics/21366",
                            "name": "Avengers: The Initiative (2007) #14"
                        }],
                        "returned": 1
                    },
                    "series": {
                        "available": 0,
                        "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011334/series",
                        "items": [],
                        "returned": 0
                    },
                    "stories": {
                        "available": 1,
                        "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011334/stories",
                        "items": [{
                            "resourceURI": "http://gateway.marvel.com/v1/public/stories/19947",
                            "name": "Cover #19947",
                            "type": "cover"
                        }],
                        "returned": 1
                    },
                    "events": {
                        "available": 1,
                        "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011334/events",
                        "items": [{
                            "resourceURI": "http://gateway.marvel.com/v1/public/events/269",
                            "name": "Secret Invasion"
                        }],
                        "returned": 1
                    },
                    "urls": [{
                        "type": "detail",
                        "url": "http://marvel.com/comics/characters/1011334/3-d_man?utm_campaign=apiRef&utm_source=0a2dd4c8bd45e7ce7dc086c8ac34760b"
                    }, {
                        "type": "wiki",
                        "url": "http://marvel.com/universe/3-D_Man_(Chandler)?utm_campaign=apiRef&utm_source=0a2dd4c8bd45e7ce7dc086c8ac34760b"
                    }, {
                        "type": "comiclink",
                        "url": "http://marvel.com/comics/characters/1011334/3-d_man?utm_campaign=apiRef&utm_source=0a2dd4c8bd45e7ce7dc086c8ac34760b"
                    }]
                }]
            }
        }
""".data(using: .utf8)!

