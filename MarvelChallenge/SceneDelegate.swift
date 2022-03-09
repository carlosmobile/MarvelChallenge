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
        let mainViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

