//
//  MainCoordinator.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 16/08/22.
//

import UIKit
final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator]?
    var navigationController: UINavigationController
    private let windowScene: UIWindowScene
    private var window: UIWindow?
    
    init(withScene windowScene: UIWindowScene) {
        let homeViewModel = HomeViewModel()
        let viewController = HomeViewController(homeViewModel)
        navigationController = UINavigationController(rootViewController: viewController)
        self.windowScene = windowScene
        homeViewModel.coordinatorDelegate = self
    }
    
    func start() {
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
extension MainCoordinator: HomeViewModelCoordinatorDelegate {
    func viewModel(_ viewModel: HomeViewModel, routeToModel model: AvatarModel) {
        let avatarCoordinator = AvatarSceneCoordinator(withModel: model, navigation: navigationController)
        avatarCoordinator.start()
    }
    
    
}
// MARK: - Route methods
protocol HomeCoordinatorDelegate: AnyObject {
    func coordinator(_ coordinator: Coordinator, routeToAvatarSceneWithModel model: AvatarModel)
}
extension MainCoordinator {
    func routeToAvatarScene(model: AvatarModel) {
        let coordinator = AvatarSceneCoordinator(withModel: model, navigation: navigationController)
        coordinator.start()
    }
}
