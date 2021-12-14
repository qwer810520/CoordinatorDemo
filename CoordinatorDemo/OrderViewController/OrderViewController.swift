//
//  OrderViewController.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/14.
//

import UIKit
import SnapKit

class OrderViewController: UIViewController {
    
    private lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - UIViewController
    
    let totalPrice: String
    
    init(price: String) {
        self.totalPrice = price
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUserInterface()
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        view.backgroundColor = .systemBlue
        view.addSubviews([totalPriceLabel])
        setupAutolayout()
        
        totalPriceLabel.text = totalPrice
    }
    
    private func setupAutolayout() {
        totalPriceLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(200)
            $0.height.equalTo(50)
        }
    }
}
