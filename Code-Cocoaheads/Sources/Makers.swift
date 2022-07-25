//
//  Makers.swift
//  Code-Cocoaheads
//
//  Created by marcos.felipe.souza on 18/07/22.
//

import UIKit


func makeWindowAndCoordinator(
    scene: UIWindowScene? = nil
) -> (uiWindow: UIWindow, coordinator: Coordinator) {
    let window = scene == nil ? UIWindow(frame: UIScreen.main.bounds) : UIWindow(windowScene: scene!)    
    window.rootViewController = UINavigationController()
    let navigationRouter = NavigationRouter(navigationController: window.rootViewController as! UINavigationController)
    let coordinator = CoordinatorUIKit(router: navigationRouter)
    coordinator.start(animated: true, onDismissed: nil)
    window.makeKeyAndVisible()
    return (window, coordinator)
}
