//
//  OtherCoordinator.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/14.
//

import UIKit

class OtherCoordinator: Coordinator<UINavigationController> {
    
    private var viewController: OtherViewController?
    
    override func start() {
        guard !isStart else { return }
        viewController = OtherViewController()
        guard let controller = viewController else { return }
        controller.delegate = self
        push(viewController: controller, animated: false)
        super.start()
    }
}

    // MARK: - OtherViewControllerDelegate

extension OtherCoordinator: OtherViewControllerDelegate {
    func presentDetail() {
        guard let controller = viewController else { return }
        let detail = OrderDetailCoordinator(viewController: controller)
        startChild(detail)
    }
}
