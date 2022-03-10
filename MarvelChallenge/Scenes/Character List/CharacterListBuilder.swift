//
//  CharacterListBuilder.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import UIKit

class CharacterListBuilder {

    static func build(_ characterDataContainer: CharacterDataContainer?) -> UIViewController {

        let viewController = CharacterListViewController(nibName: String(describing: CharacterListViewController.self),
                                                         bundle: nil)
        let presenter = CharacterListPresenter()
        let interactor = CharacterListInteractor()
        let wireframe = CharacterListWireframe()

        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        wireframe.viewController = viewController

        presenter.characterDataContainer = characterDataContainer

        return viewController
    }
}
