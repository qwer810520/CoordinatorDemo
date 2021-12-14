//
//  RootCoordinator.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/13.
//

import UIKit

class MainCoordinator: Coordinator<UINavigationController> {
    
    override func start() {
        let viewController = MainViewController()
        viewController.delegate = self
        push(viewController: viewController, animated: false)
        super.start()
    }
}

    // MARK: - ViewControllerDelegate

extension MainCoordinator: MainViewControllerDelegate {
    func rootViewControllerDidPushBuy(_ viewController: MainViewController, to productType: Int) {
        let buyCoordinator = BuyCoordinator(rootViewController: rootViewController, productType: productType)
        startChild(buyCoordinator)
    }
    
    func rootViewControllerDidPushCreateAccount(_ viewController: MainViewController) {
        print(#function)
    }
}
