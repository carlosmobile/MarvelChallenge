//
//  LoginAPIWireframe.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import UIKit

protocol LoginAPINavigationHandler: AnyObject {

    func pushCharacterList(_ characterDataContainer: CharacterDataContainer)
}

class LoginAPIWireframe: LoginAPINavigationHandler {

    weak var viewController: LoginAPIViewController?

    func pushCharacterList(_ characterDataContainer: CharacterDataContainer) {
        let vc = CharacterListBuilder.build(characterDataContainer)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
