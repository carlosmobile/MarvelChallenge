//
//  SceneDelegate.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let mainViewController = LoginAPIBuilder.build()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        let userDefaults = UserDefaults.standard

        if ProcessInfo.processInfo.arguments.contains("isUITestingLogin") {
            APIKeys.removeKeys()
        } else {
            if !userDefaults.bool(forKey: "hasRunBefore") {
                APIKeys.removeKeys()
                userDefaults.set(true, forKey: "hasRunBefore")
            } else {
                if APIKeys.isPublicAndPrivateKeyExists {
                    navigationController.pushViewController(CharacterListBuilder.build(nil), animated: false)
                }
            }
        }

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

