//
//  AppCoordinator.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/14.
//

import UIKit

class AppCoordinator: Coordinator<UITabBarController> {
    
    override func start() {
        let tabbar = RootTabbarCoordinator(viewController: rootViewController)
        startChild(tabbar)
        super.start()
    }
}
