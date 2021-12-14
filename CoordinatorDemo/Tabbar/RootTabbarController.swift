//
//  TabbarController.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/14.
//

import UIKit

class TabbarController: UITabBarController {
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func setupChildControllers() {
        
        
    }
}
