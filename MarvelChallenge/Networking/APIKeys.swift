//
//  APIKeys.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import Foundation
import CryptoKit
import KeychainAccess

class APIKeys {
    static private let keychain = Keychain(service: "com.Carlos.Marvel")

    static var isPublicAndPrivateKeyExists: Bool {
        return (keychain["publicKey"] != "" && keychain["publicKey"] != nil) &&
               (keychain["privateKey"] != "" && keychain["privateKey"] != nil)
    }

    static private func md5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }

    static func saveKeys(publicKey: String, privateKey: String) {
        keychain["publicKey"] = publicKey
        keychain["privateKey"] = privateKey
    }

    static func removeKeys() {
        do {
            try keychain.removeAll()
        } catch let error {
            #if DEBUG
                print("error: \(error)")
            #endif
        }
    }

    static func requestMarvelKeys() -> (timestamp: Int64, apikey: String, hash: String) {
        let timestamp = Int64(Date().timeIntervalSince1970 * 1000)
        if let publicKey = keychain["publicKey"], let privateKey = keychain["privateKey"] {
            let hash = md5(string: String(format: "%@%@%@", String(timestamp), privateKey, publicKey))
            return (timestamp, publicKey, hash)
        } else {
            return (timestamp, "", "")
        }
    }
}
