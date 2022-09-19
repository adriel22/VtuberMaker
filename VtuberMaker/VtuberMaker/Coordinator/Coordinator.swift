//
//  Coordinator.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 16/08/22.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator]? { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
