//
//  CoordinatorUIKit.swift
//  Code-Cocoaheads
//
//  Created by marcos.felipe.souza on 18/07/22.
//

import UIKit
import SwiftUI

public protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var router: Router { get }
    var viewController: UIViewController? { get }
    
    func start(animated: Bool, onDismissed: (() -> Void)?)
    func dismiss(animated: Bool)
}

public extension Coordinator {
    func onDismissed(coordinator: Coordinator) -> Void {
        self.children.removeAll { $0 === coordinator }
    }
}

class CoordinatorUIKit: Coordinator, CoordinatorUIKitDelegate {
    
    var rootViewController: ViewController?
    
    var viewController: UIViewController? {
        rootViewController
    }
    
    var children: [Coordinator] = []
    
    var router: Router
    
    init(router: Router) {
        self.router = router
    }

    func start(animated: Bool, onDismissed: (() -> Void)?) {
        rootViewController = ViewController()
        rootViewController?.coordinator = self
        router.present(rootViewController!, animated: true, onDismissed: onDismissed)
    }
    
    func dismiss(animated: Bool) {
        router.dismiss(animated: animated)
    }
    
    func didTapFirstElement() {
        let firstCoordinator = CoordinatorSwiftUI(router: router)
        children.append(firstCoordinator)
        firstCoordinator.start(animated: true) {
            self.children.removeAll { $0 === firstCoordinator}
        }
    }
    
    func didTapSecondElement() {
        let secondCoordinator = ListCoordinatorViewHostingController()
        router.present(secondCoordinator, animated: true)
    }
}

protocol CoordinatorUIKitDelegate: AnyObject {
    func didTapFirstElement()
    func didTapSecondElement()
}

