//
//  LoginAPIViewModel.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginAPIViewModel {
    let publicKey = BehaviorRelay<String>(value: "")
    let privateKey = BehaviorRelay<String>(value: "")
    let isValidPublicKey = BehaviorRelay<Bool>(value: false)
    let isValidPrivateKey = BehaviorRelay<Bool>(value: false)
    let characterDataContainer = BehaviorRelay<CharacterDataContainer?>(value: nil)
    let showActivityIndicator = BehaviorRelay<Bool>(value: false)
}

