//
//  OtherViewController.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/14.
//

import UIKit

class OtherViewController: UIViewController {
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUserInterface()
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        view.backgroundColor = .systemGreen
    }
}


