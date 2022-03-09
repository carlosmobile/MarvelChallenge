//
//  CharacterListInteractor.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import Foundation

protocol CharacterListRequestHandler: AnyObject {
    
    // func requestSomething()
}

class CharacterListInteractor: CharacterListRequestHandler {
    
    //MARK: Relationships
    
    weak var presenter: CharacterListResponseHandler?
    
    //MARK: - RequestHandler Protocol
    
    //func requestSomething(){}
}
