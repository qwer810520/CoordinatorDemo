//
//  RootCoordinator.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/13.
//

import UIKit

class RootCoordinator: Coordinator<UINavigationController> {
    
    override func start() {
        let viewController = ViewController()
        viewController.delegate = self
        push(viewController: viewController, animated: false)
        super.start()
    }
}

    // MARK: - ViewControllerDelegate

extension RootCoordinator: ViewControllerDelegate {
    func rootViewControllerDidPushBuy(_ viewController: ViewController, to productType: Int) {
        let buyCoordinator = BuyCoordinator(rootViewController: rootViewController, productType: productType)
        startChild(buyCoordinator)
    }
    
    func rootViewControllerDidPushCreateAccount(_ viewController: ViewController) {
        print(#function)
    }
}
