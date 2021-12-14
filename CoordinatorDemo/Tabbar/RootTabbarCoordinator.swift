//
//  RootTabbarCoordinator.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/14.
//

import UIKit

class RootTabbarCoordinator: Coordinator<UITabBarController> {
    
    private var mainCoordinator: MainCoordinator?
    private var otherCoordinator: OtherCoordinator?
    private var selectedCoordinator: CoordinatorType?
    
    override func start() {
        setupChildViewControllers()
        if let rootTabbarController = rootViewController as? RootTabbarController {
            rootTabbarController.customDelegate = self
        }
        
        let main = childCoordinators[0]
        main.start()
        selectedCoordinator = main
        super.start()
    }
}


extension RootTabbarCoordinator {
    func setupChildViewControllers() {
        func setupNavigation() -> UINavigationController {
            return BaseNavigationController()
        }
        
        let mainNavigation = setupNavigation()
        mainNavigation.tabBarItem = UITabBarItem(title: "Main", image: nil, tag: 0)
        let main = MainCoordinator(viewController: mainNavigation)
        mainCoordinator = main
        
        let otherNavigation = setupNavigation()
        otherNavigation.tabBarItem = UITabBarItem(title: "Other", image: nil, tag: 1)
        let other = OtherCoordinator(viewController: otherNavigation)
        otherCoordinator = other
        
        childCoordinators = [main, other]
        childCoordinators.forEach { $0.parent = self }
        rootViewController.viewControllers = [mainNavigation, otherNavigation]
    }
}

    // MARK: - RootTabbarControllerDelegate

extension RootTabbarCoordinator: RootTabbarControllerDelegate {
    func tabbarDidSelectItem(with index: Int) {
        let newSelectedCoordinator = childCoordinators[index]
        
        guard selectedCoordinator !== newSelectedCoordinator else { return }
        selectedCoordinator?.deactivate()
        newSelectedCoordinator.start()
        selectedCoordinator = newSelectedCoordinator
    }
}

