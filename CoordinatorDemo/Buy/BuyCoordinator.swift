//
//  BuyCoordinator.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/14.
//

import UIKit

class BuyCoordinator: Coordinator<UINavigationController> {
    
    private var selectProductIndex: Int
        
    // MARK: - Initialization
    
    init(rootViewController: UINavigationController, productType: Int) {
        self.selectProductIndex = productType
        super.init(viewController: rootViewController)
    }
    
    override func start() {
        let viewController = BuyViewController()
        viewController.delegate = self
        push(viewController: viewController, animated: true)
        super.start()
    }
}

    // MARK: - BuyViewControllerDelegate

extension BuyCoordinator: BuyViewControllerDelegate {
    func toCheckOrderResult(with result: String) {
        let order = OrderCoordinator(viewController: rootViewController, orderPrice: result)
        startChild(order)
    }
    
    func popToMainController() {
        pop()
    }
}


