//
//  OrderViewController.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/14.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol OrderViewControllerDelegate: AnyObject {
    func popToRootController()
}

class OrderViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    weak var delegate: OrderViewControllerDelegate?
    
    private lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var popToRootButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pop to rootViewController", for: .normal)
        button.setTitleColor(.darkText, for: .normal)
        return button
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
        setupUserInterface()
        bindingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        view.backgroundColor = .white
        view.addSubviews([totalPriceLabel, popToRootButton])
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
        
        popToRootButton.snp.makeConstraints {
            $0.left.equalTo(totalPriceLabel.snp.left)
            $0.right.equalTo(totalPriceLabel.snp.right)
            $0.height.equalTo(totalPriceLabel.snp.height)
            $0.top.equalTo(totalPriceLabel.snp.bottom).offset(50)
        }
    }
    
    private func bindingView() {
        popToRootButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.popToRootController()
                
            }).disposed(by: disposeBag)
    }
}
