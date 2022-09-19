//
//  HomeViewModel.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 16/08/22.
//

import Foundation
protocol HomeViewModelCoordinatorDelegate: AnyObject {
    func viewModel(_ viewModel: HomeViewModel, routeToModel model: AvatarModel)
}
final class HomeViewModel {
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?

    
    func getSavedModels() -> [AvatarModel] {
        // TODO: Implement the real method
        [AvatarModel(), AvatarModel(), AvatarModel()]
    }
    
    func routeToModel(_ avaterModel: AvatarModel) {
        coordinatorDelegate?.viewModel(self, routeToModel: avaterModel)
    }
}
