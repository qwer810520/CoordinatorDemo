//
//  OrderDetailViewController.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit

protocol OrderDetailViewControllerDelegate: AnyObject {
    func dismiss()
}

class OrderDetailViewController: UIViewController {
    
    weak var delegate: OrderDetailViewControllerDelegate?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUserInterface()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        delegate?.dismiss()
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        view.backgroundColor = .systemPink
    }
}
