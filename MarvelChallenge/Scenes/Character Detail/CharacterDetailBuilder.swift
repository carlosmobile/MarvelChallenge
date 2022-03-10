//
//  CharacterDetailBuilder.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 10/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import UIKit

class CharacterDetailBuilder {

    static func build(_ character: Character) -> UIViewController {

        let viewController = CharacterDetailViewController(nibName:String(describing: CharacterDetailViewController.self), bundle: nil)
        let presenter = CharacterDetailPresenter()
        let interactor = CharacterDetailInteractor()
        let wireframe = CharacterDetailWireframe()

        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        wireframe.viewController = viewController

        presenter.character = character

        return viewController
    }
}
