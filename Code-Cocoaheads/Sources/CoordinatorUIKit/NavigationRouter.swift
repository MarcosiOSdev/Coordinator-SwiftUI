//
//  NavigationRouter.swift
//  Code-Cocoaheads
//
//  Created by marcos.felipe.souza on 18/07/22.
//

import UIKit

public protocol UINavigationControllerProtocol: AnyObject, Presentable {
    var delegate: UINavigationControllerDelegate? { get set }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    
    @discardableResult
    func popViewController(animated: Bool) -> UIViewController?
    @discardableResult
    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]?
    @discardableResult
    func popToRootViewController(animated: Bool) -> [UIViewController]?
    
    var topViewController: UIViewController? { get }
    var visibleViewController: UIViewController? { get }
    
    var viewControllers: [UIViewController] { get set }
    
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
}

extension UINavigationController: UINavigationControllerProtocol { }



public class NavigationRouter: NSObject {
    public let navigationController: UINavigationControllerProtocol
    private var routerRootController: UIViewController?
    private var onDismissForViewController: [UIViewController: (() -> Void)] = [:]
    
    public init(navigationController: UINavigationControllerProtocol) {
        self.navigationController = navigationController
        self.routerRootController = navigationController.viewControllers.first
        super.init()
        navigationController.delegate = self
    }
    
    private func setupFirstController(_ present: Presentable) {
        routerRootController = present.toPresent()
        navigationController.viewControllers = [routerRootController!]
    }
}

extension NavigationRouter: Router {
    
    public func present(_ present: Presentable, animated: Bool, onDismissed: (() -> Void)?) {
        guard routerRootController != nil else {
            setupFirstController(present)
            return
        }
        onDismissForViewController[present.toPresent()] = onDismissed
        navigationController.pushViewController(present.toPresent(), animated: animated)
    }
    
    public func dismiss(animated: Bool) {
        guard let routerRootController = routerRootController else {
            navigationController.popToRootViewController(animated: animated)
            return
        }
        performOnDismissed(for: routerRootController)
        navigationController.popToViewController(routerRootController, animated: animated)
    }
    
    private func performOnDismissed(for viewController: UIViewController) {
        guard let onDismiss = onDismissForViewController[viewController] else { return }
        onDismiss()
        onDismissForViewController[viewController] = nil
    }
    
    public func toPresent() -> UIViewController {
        return navigationController.toPresent()
    }
}

extension NavigationRouter: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let dismissedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(dismissedViewController) else { return }
        performOnDismissed(for: dismissedViewController)
    }
    
}
