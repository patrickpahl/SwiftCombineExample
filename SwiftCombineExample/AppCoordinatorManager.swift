//
//  AppCoordinatorManager.swift
//  SwiftCombineExample
//
//  Created by Patrick Pahl on 3/14/21.
//

import UIKit

class AppCoordinatorManager {
    private static var internalManager = InternalAppCoordinatorManager.shared
    
    static func start(withWindow window: UIWindow?) {
        internalManager.start(withWindow: window)
    }

}

class InternalAppCoordinatorManager {
    static let shared = InternalAppCoordinatorManager()
    private var window: UIWindow?
    
    private init() {}
    
    func start(withWindow window: UIWindow?) {
        self.window = window
        let coordinator = MainViewCoordinator(with: window)
        window?.makeKeyAndVisible()
        coordinator.start()
    }

}
