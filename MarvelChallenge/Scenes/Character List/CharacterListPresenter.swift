//
//  CharacterListPresenter.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import Foundation

protocol CharacterListEventHandler: AnyObject {
    
    var viewModel: CharacterListViewModel { get }
    
    func handleViewWillAppear()
    func handleViewWillDisappear()
}

protocol CharacterListResponseHandler: AnyObject {
    
    // func somethingRequestWillStart()
    // func somethingRequestDidStart()
    // func somethingRequestWillFinish()
    // func somethingRequestDidFinish()
}

class CharacterListPresenter: CharacterListEventHandler, CharacterListResponseHandler {
    
    //MARK: Relationships
    
    weak var viewController: CharacterListViewUpdatesHandler?
    var interactor: CharacterListRequestHandler!
    var wireframe: CharacterListNavigationHandler!

    var viewModel = CharacterListViewModel()
    
    //MARK: - EventHandler Protocol
    
    func handleViewWillAppear() {
    }
    
    func handleViewWillDisappear() {
    }
    
    //MARK: - ResponseHandler Protocol
    
    // func somethingRequestWillStart(){}
    // func somethingRequestDidStart(){}
    // func somethingRequestWillFinish(){}
    // func somethingRequestDidFinish(){}
}
