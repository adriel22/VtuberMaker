//
//  SceneDelegate.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 08/08/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let viewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let navigation = UINavigationController(rootViewController: viewController)
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }

}

