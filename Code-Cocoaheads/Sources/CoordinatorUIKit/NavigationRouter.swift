//
//  NavigationRouter.swift
//  Code-Cocoaheads
//
//  Created by marcos.felipe.souza on 18/07/22.
//

import UIKit

public class NavigationRouter: NSObject {
    public let navigationController: UINavigationController
    private var routerRootController: UIViewController?
    private var onDismissForViewController: [UIViewController: (() -> Void)] = [:]
    
    public init(navigationController: UINavigationController) {
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
