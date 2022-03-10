//
//  CharacterDetailPresenter.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 10/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import Foundation

protocol CharacterDetailEventHandler: AnyObject {

    var viewModel: CharacterDetailViewModel { get }

    func handleViewUpdateITems(offset: Int, type: ItemType)
    func handleItemSelected(extendedDetail: Item)
    func handleWikiSelected(_ wikiURL: String)
}

protocol CharacterDetailResponseHandler: AnyObject {

    func characterDetailRequestDidFinish()
    func characterDetailRequestError(message: String, errorType: APIError)
    func characterItemsRequestData(response: ItemDataContainer)
}

class CharacterDetailPresenter: CharacterDetailEventHandler, CharacterDetailResponseHandler {

    //MARK: Relationships

    weak var viewController: CharacterDetailViewUpdatesHandler?
    var interactor: CharacterDetailRequestHandler!
    var wireframe: CharacterDetailNavigationHandler!

    var viewModel = CharacterDetailViewModel()
    var character: Character? {
        didSet {
            if let characterData = character {
                viewModel.characterData.accept(characterData)
            }
        }
    }

    //MARK: - EventHandler Protocol

    func handleViewUpdateITems(offset: Int, type: ItemType) {
        guard let id = character?.id else { return }
        interactor.requestDetailItems(offset: offset, id, type)
    }

    func handleItemSelected(extendedDetail: Item) {
        wireframe.presenterExtenderDetail(extendedDetail)
    }

    func handleWikiSelected(_ wikiURL: String) {
        wireframe.presenterCharacterWiki(wikiURL)
    }

    //MARK: - ResponseHandler Protocol

    func characterDetailRequestDidFinish() {
        viewModel.showActivityIndicator.accept(false)
    }

    func characterDetailRequestError(message: String, errorType: APIError) {
        viewController?.updateCharacterDetailViewWithAlert(message, errorType)
    }

    func characterItemsRequestData(response: ItemDataContainer) {
        viewModel.itemDataContainer.accept(response)
        viewController?.updateItemsView(type: response.formatType)
    }
}
