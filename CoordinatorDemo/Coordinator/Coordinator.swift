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
}

class Coordinator<T: UIViewController>: CoordinatorType {
    
    var childCoordinators: [CoordinatorType]
    weak final var parent: CoordinatorType?
    
    let rootViewController: T
    
    private(set) var isStart = false
    
    init(viewController: T) {
        self.rootViewController = viewController
        self.childCoordinators = []
    }
    
    func start() {
        isStart = true
    }
    
    func stop() {
        isStart = false
        stopChildren()
    }
    
    func startChild(_ coordinator: CoordinatorType) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        coordinator.parent = self
        childCoordinators.append(coordinator)
        coordinator.start()
        print("\(#function), coodinator is \(self),childCoordinators: \(childCoordinators)")
    }
    
    func stopChild(_ coordinator: CoordinatorType) {
        coordinator.stop()
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            coordinator.childCoordinators.remove(at: index)
        }
    }
    
    // MARK: - Private Methods
    
    final func stopChildren() {
        childCoordinators.forEach {
            $0.stop()
        }
        childCoordinators.removeAll()
    }
}

    // MARK: - Present and dismiss

extension Coordinator where T: UIViewController {
    func present(viewController: UIViewController, animated: Bool = true) {
        viewController.coordinator = self
        rootViewController.present(viewController, animated: animated)
    }
    
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        // TODO
        rootViewController.dismiss(animated: animated) {
            self.parent?.stopChild(self)
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
        print("controller: \(viewController), coordinator: \(viewController.coordinator)")
        guard !rootViewController.viewControllers.contains(viewController) else { return }
        rootViewController.pushViewController(viewController, animated: animated)
        
        print("------------->")
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
