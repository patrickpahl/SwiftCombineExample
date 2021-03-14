//
//  MainViewCoordinator.swift
//  SwiftCombineExample
//
//  Created by Patrick Pahl on 3/14/21.
//

import UIKit

class MainViewCoordinator: MainViewCoordinatorProtocol {
    func doStuff() {
        
    }
    
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    init(with window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let viewController = MainViewController()
        let viewModel: MainViewModelProtocol = MainViewModel()
        viewController.viewModel = viewModel
        viewModel.view = viewController
        viewModel.coordinator = self
        navigationController = UINavigationController(rootViewController: viewController)
        
        window?.rootViewController = navigationController
    }
    
}
