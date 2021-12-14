//
//  BuyViewController.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/13.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

protocol BuyViewControllerDelegate: AnyObject {
    func toCheckOrderResult(with result: String)
    func popToMainController()
}

class BuyViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var popButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pop", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    
    private lazy var pushButton: UIButton = {
        let button = UIButton()
        button.setTitle("Push", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    weak var delegate: BuyViewControllerDelegate?
    var selectProductIndex = 0
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        view.backgroundColor = .white
        view.addSubviews([titleLabel, popButton, pushButton])
        setupAutolayout()
        bindingView()
        
        titleLabel.text = "\(type(of: self)) index: \(selectProductIndex)"
    }
    
    private func setupAutolayout() {
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(100)
            $0.height.equalTo(40)
        }
        
        popButton.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
            $0.right.equalTo(titleLabel.snp.right)
            $0.height.equalTo(titleLabel.snp.height)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
        }
        
        pushButton.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
            $0.right.equalTo(titleLabel.snp.right)
            $0.height.equalTo(titleLabel.snp.height)
            $0.top.equalTo(popButton.snp.bottom).offset(40)
        }
    }
    
    private func bindingView() {
        popButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] _ in
                print("popButton did Pressed")
                self?.delegate?.popToMainController()
            })
            .disposed(by: disposeBag)
        
        pushButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                print("pushButton did Pressed")
                guard let self = self else { return }
                self.delegate?.toCheckOrderResult(with: "\(self.selectProductIndex + 1500)")
            })
            .disposed(by: disposeBag)
    }
}
