//
//  LoginAPIPresenter.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import Foundation

protocol LoginAPIEventHandler: AnyObject {

    var viewModel: LoginAPIViewModel { get }

    func handleSendAPIKeys()
    func handleSendAPIKeysSuccess()
}

protocol LoginAPIResponseHandler: AnyObject {

    func apiRequestDidFinish()
    func apiRequestError(message: String, errorType: APIError)
    func apiRequestData(response: CharacterDataContainer)
}

class LoginAPIPresenter: LoginAPIEventHandler, LoginAPIResponseHandler {

    //MARK: Relationships

    weak var viewController: LoginAPIViewUpdatesHandler?
    var interactor: LoginAPIRequestHandler!
    var wireframe: LoginAPINavigationHandler!

    var viewModel = LoginAPIViewModel()

    //MARK: - EventHandler Protocol

    func handleSendAPIKeys() {
        viewModel.showActivityIndicator.accept(true)
        interactor.requestCharacters()
    }

    func handleSendAPIKeysSuccess() {
        guard let characterDataContainer = viewModel.characterDataContainer.value else { return }
        wireframe.pushCharacterList(characterDataContainer)
    }

    //MARK: - ResponseHandler Protocol

    func apiRequestDidFinish() {
        viewModel.showActivityIndicator.accept(false)
    }

    func apiRequestError(message: String, errorType: APIError) {
        APIKeys.removeKeys()
        viewController?.updateLoginAPIViewWithAlert(message, errorType)
    }

    func apiRequestData(response: CharacterDataContainer) {
        viewModel.characterDataContainer.accept(response)
        viewController?.updateLoginAPIView()
    }
}

