//
//  BaseNavigationController.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/13.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            navigationBar.scrollEdgeAppearance = appearance
        }
        
        delegate = self
    }
}

// MARK: - UINavigationControllerDelegate

extension BaseNavigationController: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(previousViewController) else {
            return
        }
        
        viewController.coordinator?.stopChildren()
    }
}



