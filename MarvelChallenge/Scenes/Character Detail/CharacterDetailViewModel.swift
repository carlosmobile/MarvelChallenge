//
//  CharacterDetailViewModel.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 10/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct CharacterDetailViewModel {

    let characterData = BehaviorRelay<Character?>(value: nil)
    let itemDataContainer = BehaviorRelay<ItemDataContainer?>(value: nil)
    let showActivityIndicator = BehaviorRelay<Bool>(value: false)
}
