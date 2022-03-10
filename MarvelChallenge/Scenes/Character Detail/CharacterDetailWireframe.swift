//
//  CharacterDetailWireframe.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 10/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import UIKit

protocol CharacterDetailNavigationHandler: AnyObject {

    func presenterExtenderDetail(_ extendedDetail: Item)
    func presenterCharacterWiki(_ wikiURL: String)
}

class CharacterDetailWireframe: CharacterDetailNavigationHandler {

    weak var viewController: CharacterDetailViewController?

    func presenterExtenderDetail(_ extendedDetail: Item) {
        let vc = ExtendDetailViewController()
        vc.extendDetailData = extendedDetail
        viewController?.present(vc, animated: true, completion: nil)
    }

    func presenterCharacterWiki(_ wikiURL: String) {
        let vc = CharacterWikiViewController()
        vc.characterWikiURL = wikiURL
        viewController?.present(vc, animated: true, completion: nil)
    }
}
