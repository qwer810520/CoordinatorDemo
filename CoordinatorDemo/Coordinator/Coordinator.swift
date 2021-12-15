//
//  Coordinator.swift
//  CoordinatorDemo
//
//  Created by Min on 2021/12/13.
//

import UIKit

protocol CoordinatorType: AnyObject {
    var childCoordinators: [CoordinatorType] { get set }
    var parent: CoordinatorType? { get set }
    
    func start()
    func stop()
    
    func startChild(_ coordinator: CoordinatorType)
    func stopChild(_ coordinator: CoordinatorType)
    
    func stopChildren()
    
    func active()
    func deactivate()
    
}

class Coordinator<T: UIViewController>: CoordinatorType {
    
    var childCoordinators: [CoordinatorType]
    weak final var parent: CoordinatorType?
    
    let rootViewController: T
    
    private(set) var isStart = false
    private(set) var isActive = false
    
    init(viewController: T) {
        self.rootViewController = viewController
        self.childCoordinators = []
    }
    
    func start() {
        isStart = true
        isActive = true
    }
    
    func stop() {
        isStart = false
        isActive = false
        stopChildren()
    }
    
    func startChild(_ coordinator: CoordinatorType) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        coordinator.parent = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func stopChild(_ coordinator: CoordinatorType) {
        coordinator.stop()
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
    final func stopChildren() {
        childCoordinators.forEach {
            $0.stop()
        }
        childCoordinators.removeAll()
    }
}

    // MARK: - Only Tabbar Use

extension Coordinator {
    func active() {
        isActive = true
        childCoordinators.forEach { $0.active() }
    }
    
    func deactivate() {
        isActive = false
        childCoordinators.forEach { $0.deactivate() }
    }
}

    // MARK: - Present and dismiss

extension Coordinator where T: UIViewController {
    func present(viewController: UIViewController, animated: Bool = true) {
        viewController.coordinator = self
        rootViewController.present(viewController, animated: animated)
    }
    
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        var target: CoordinatorType?
        if let navigationController = rootViewController.presentedViewController as? UINavigationController {
            target = navigationController.viewControllers.first?.coordinator
        } else {
            target = self
        }
        rootViewController.dismiss(animated: animated) {
            if let target = target {
                self.parent?.stopChild(target)
            }
            completion?()
        }
    }
}

    // MARK: - Push and Pop

extension Coordinator where T: UINavigationController {
    var coordinatorsAtNavigationController: [CoordinatorType] {
        rootViewController.viewControllers.compactMap { $0.coordinator }
    }
    
    func push(viewController: UIViewController, animated: Bool = true) {
        viewController.coordinator = self
        guard !rootViewController.viewControllers.contains(viewController) else { return }
        rootViewController.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        rootViewController.popViewController(animated: animated)
    }
    
    func pop(to coordinator: CoordinatorType) {
        guard let index = coordinatorsAtNavigationController.firstIndex(where: { $0 === coordinator }) else { return }
        let destinationVC = rootViewController.viewControllers[index]
        rootViewController.popToViewController(destinationVC, animated: true)
        
    }
}
    // MARK: - UIViewController Extension

extension UIViewController {
    private struct CoordinatorAssociatedKeys {
        static var ownerKey: UInt = 0
    }

    weak var coordinator: CoordinatorType? {
        get { objc_getAssociatedObject(self, &CoordinatorAssociatedKeys.ownerKey) as? CoordinatorType }
        set { objc_setAssociatedObject(self, &CoordinatorAssociatedKeys.ownerKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
}
