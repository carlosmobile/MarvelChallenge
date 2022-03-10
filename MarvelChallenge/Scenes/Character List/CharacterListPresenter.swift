//
//  CharacterListPresenter.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import Foundation

enum RequestType: Int {
    case characterRegular
    case characterSearch
    case characterRegularLoadMore
    case characterSearchLoadMore
}


protocol CharacterListEventHandler: AnyObject {

    var viewModel: CharacterListViewModel { get }

    func handleRequestData(from: Int, nameStartsWith: String, requestType: RequestType)
    func handleItemSelected(character: Character)
}

protocol CharacterListResponseHandler: AnyObject {

    func characterRequestDidFinish()
    func characterRequestError(message: String, errorType: APIError)
    func characterRequestDataRegular(response: CharacterDataContainer)
    func characterRequestDataSearchFilter(response: CharacterDataContainer)
}

class CharacterListPresenter: CharacterListEventHandler, CharacterListResponseHandler {

    //MARK: Relationships

    weak var viewController: CharacterListViewUpdatesHandler?
    var interactor: CharacterListRequestHandler!
    var wireframe: CharacterListNavigationHandler!
    var viewModel = CharacterListViewModel()
    var characterDataContainer: CharacterDataContainer? {
        didSet {
            if let characterData = characterDataContainer {
                viewModel.characterDataContainerRegular.accept(characterData)
                viewModel.isSearching.accept(false)
            }
        }
    }

    //MARK: - EventHandler Protocol

    func handleRequestData(from: Int, nameStartsWith: String, requestType: RequestType) {

        var offset: Int?

        switch requestType {
        case .characterRegular, .characterSearch:
            viewModel.showActivityIndicator.accept(true)
            offset = 0
        case .characterRegularLoadMore, .characterSearchLoadMore:
            offset = from
        }

        interactor.requestCharacters(offset, nameStartsWith)
    }

    func handleItemSelected(character: Character) {
        wireframe.pushCharacterDetail(character)
    }

    //MARK: - ResponseHandler Protocol

    func characterRequestDidFinish() {
        viewModel.showActivityIndicator.accept(false)
    }

    func characterRequestError(message: String, errorType: APIError) {
        viewController?.updateCharacterListViewWithAlert(message, errorType)
    }

    func characterRequestDataRegular(response: CharacterDataContainer) {
        viewModel.characterDataContainerRegular.accept(response)
        viewModel.isSearching.accept(false)
        viewController?.updateCharacterListView()
    }

    func characterRequestDataSearchFilter(response: CharacterDataContainer) {
        viewModel.characterDataContainerSearchFilter.accept(response)
        viewModel.isSearching.accept(true)
        viewController?.updateCharacterListView()
    }
}
