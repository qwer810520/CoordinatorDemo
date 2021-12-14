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
        push(viewController: viewController, animated: true)
        super.start()
    }
}
