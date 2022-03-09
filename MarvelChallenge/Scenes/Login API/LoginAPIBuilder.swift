//
//  LoginAPIBuilder.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import UIKit

class LoginAPIBuilder {

    static func build() -> UIViewController {

        let viewController = LoginAPIViewController(nibName: String(describing: LoginAPIViewController.self),
                                                    bundle: nil)
        let presenter = LoginAPIPresenter()
        let interactor = LoginAPIInteractor()
        let wireframe = LoginAPIWireframe()

        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        wireframe.viewController = viewController

        return viewController
    }
}
