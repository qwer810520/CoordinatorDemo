//
//  OrderDetailCoordinator.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit

class OrderDetailCoordinator: Coordinator<UIViewController> {
    
    override func start() {
        let controller = OrderDetailViewController()
        controller.delegate = self
        controller.modalPresentationStyle = .fullScreen
        present(viewController: controller, animated: true)
        super.start()
    }
}

    // MARK: - OrderDetailViewControllerDelegate

extension OrderDetailCoordinator: OrderDetailViewControllerDelegate {
    func dismiss() {
        dismiss(animated: true)
    }
}
