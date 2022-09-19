//
//  AvatarSceneCoordinator.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 16/08/22.
//

import UIKit
final class AvatarSceneCoordinator: Coordinator {
    var childCoordinators: [Coordinator]?
    var navigationController: UINavigationController
    private var model: AvatarModel
    
    init(withModel model: AvatarModel, navigation: UINavigationController) {
        navigationController = navigation
        self.model = model
    }
    
    func start() {
        let controller = AvatarSceneViewController(withModel: model)
        navigationController.pushViewController(controller, animated: true)
    }
    
    
}
