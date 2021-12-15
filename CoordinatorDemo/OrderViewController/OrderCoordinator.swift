//
//  OrderCoordinator.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/14.
//

import UIKit

class OrderCoordinator: Coordinator<UINavigationController> {
    
    private let orderPrice: String
    
    // MARK: - Initialization
    
    init(viewController: UINavigationController, orderPrice: String) {
        self.orderPrice = orderPrice
        super.init(viewController: viewController)
    }
    
    override func start() {
        let viewController = OrderViewController(price: orderPrice)
        viewController.delegate = self
        push(viewController: viewController, animated: true)
        super.start()
    }
}

    // MARK: - OrderViewControllerDelegate

extension OrderCoordinator: OrderViewControllerDelegate {
    func popToRootController() {
        guard let coordinator = coordinatorsAtNavigationController.last(where: { $0 is MainCoordinator }) else { return }
        pop(to: coordinator)
    }
}
