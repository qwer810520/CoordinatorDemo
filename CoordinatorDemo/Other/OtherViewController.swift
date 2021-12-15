//
//  OtherViewController.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/14.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol OtherViewControllerDelegate: AnyObject {
    func presentDetail()
}

class OtherViewController: UIViewController {
    
    private let disposebag = DisposeBag()
    weak var delegate: OtherViewControllerDelegate?
    
    private lazy var presentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    
    // MARK: - UIViewController
    
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
        view.addSubviews([presentButton])
        setupAutolayout()
    }
    
    private func setupAutolayout() {
        presentButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
            $0.height.equalTo(50)
        }
    }
    
    private func bindingView() {
        presentButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.presentDetail()
            }).disposed(by: disposebag)
    }
}


