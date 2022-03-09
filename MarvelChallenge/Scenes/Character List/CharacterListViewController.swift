//
//  CharacterListViewController.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import UIKit

protocol CharacterListViewUpdatesHandler: AnyObject {
    //func updateSomeView()
}

class CharacterListViewController: UIViewController, CharacterListViewUpdatesHandler {
    
    //MARK: Relationships
    
    var presenter: CharacterListEventHandler!
    
    var viewModel: CharacterListViewModel {
        return presenter.viewModel
    }
    
    //MARK: - IBOutlets
    
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        configureOutlets()
    }
    
    func configureBindings() {
        //Add the ViewModel bindings here ...
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.handleViewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.handleViewWillDisappear()
    }
    
    //MARK: - UI Configuration
    
    private func configureOutlets() {
        
    }
    
    //MARK: - CharacterListViewUpdatesHandler
    
    
    //MARK: - Private methods
    
}
