//
//  CharacterListWireframe.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import UIKit

protocol CharacterListNavigationHandler: AnyObject {

    func pushCharacterDetail(_ character: Character)
}

class CharacterListWireframe: CharacterListNavigationHandler {

    weak var viewController: CharacterListViewController?

    func pushCharacterDetail(_ character: Character) {
        let vc = CharacterDetailBuilder.build(character)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
