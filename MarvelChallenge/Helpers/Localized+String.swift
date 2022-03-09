//
//  Localized+String.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func localized(withComment comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
