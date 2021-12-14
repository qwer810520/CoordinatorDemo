//
//  OtherCoordinator.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/14.
//

import UIKit

class OtherCoordinator: Coordinator<UINavigationController> {
    
    override func start() {
        guard !isStart else { return }
        let viewController = OtherViewController()
        push(viewController: viewController, animated: false)
        super.start()
    }
}
