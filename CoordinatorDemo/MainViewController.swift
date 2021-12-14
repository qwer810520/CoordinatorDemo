//
//  ViewController.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/10.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

protocol MainViewControllerDelegate: AnyObject {
    func rootViewControllerDidPushBuy(_ viewController: MainViewController, to productType: Int)
    func rootViewControllerDidPushCreateAccount(_ viewController: MainViewController)
}

class MainViewController: UIViewController {
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        return button
    }()
    
    private lazy var creatAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .darkGray
        return button
    }()
    
    private lazy var productSegmented: UISegmentedControl = {
        let view = UISegmentedControl(items: ["First","Second"])
        view.selectedSegmentIndex = 0
        return view
    }()
    
    private let disposeBag = DisposeBag()
    weak var delegate: MainViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        view.backgroundColor = .white
        view.addSubviews([buyButton, creatAccountButton, productSegmented])
        setupAutolayout()
        bindingView()
    }
    
    private func setupAutolayout() {
        buyButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-20)
            $0.left.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(150)
            $0.height.equalTo(50)
        }
        
        creatAccountButton.snp.makeConstraints {
            $0.top.equalTo(buyButton.snp.bottom).offset(50)
            $0.height.equalTo(buyButton.snp.height)
            $0.left.equalTo(buyButton.snp.left)
            $0.right.equalTo(buyButton.snp.right)
        }
        
        productSegmented.snp.makeConstraints {
            $0.top.equalTo(creatAccountButton.snp.bottom).offset(50)
            $0.height.equalTo(buyButton.snp.height)
            $0.left.equalTo(buyButton.snp.left)
            $0.right.equalTo(buyButton.snp.right)
        }
    }
    
    private func bindingView() {
        buyButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] _ in
                print("buyButton did Pressend")
                guard let self = self else { return }
                self.delegate?.rootViewControllerDidPushBuy(self, to: self.productSegmented.selectedSegmentIndex)
            })
            .disposed(by: disposeBag)
        
        creatAccountButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] _ in
                print("creatAccountButton did Pressend")
                guard let self = self else { return }
                self.delegate?.rootViewControllerDidPushCreateAccount(self)
            })
            .disposed(by: disposeBag)
        
        productSegmented.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                print("didSelectSegmentedIndex is \(self.productSegmented.selectedSegmentIndex)")
            })
            .disposed(by: disposeBag)
    }
}

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}

