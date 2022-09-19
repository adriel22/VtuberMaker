//
//  SceneDelegate.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 08/08/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        coordinator = MainCoordinator(withScene: windowScene)
        coordinator?.start()
    }

}

