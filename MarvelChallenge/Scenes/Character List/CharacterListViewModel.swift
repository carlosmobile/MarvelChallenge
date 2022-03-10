//
//  CharacterListViewModel.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct CharacterListViewModel {

    let characterDataContainerRegular = BehaviorRelay<CharacterDataContainer?>(value: nil)
    let characterDataContainerSearchFilter = BehaviorRelay<CharacterDataContainer?>(value: nil)
    let showActivityIndicator = BehaviorRelay<Bool>(value: false)
    let isSearching = BehaviorRelay<Bool>(value: false)
}
