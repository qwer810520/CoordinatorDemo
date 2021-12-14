//
//  RootTabbarController.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/14.
//

import UIKit

protocol RootTabbarControllerDelegate: AnyObject {
    func tabbarDidSelectItem(with index: Int)
}

class RootTabbarController: UITabBarController {
    
    weak var customDelegate: RootTabbarControllerDelegate?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}

    // MARK: - UITabBarControllerDelegate

extension RootTabbarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        customDelegate?.tabbarDidSelectItem(with: item.tag)
    }
}
