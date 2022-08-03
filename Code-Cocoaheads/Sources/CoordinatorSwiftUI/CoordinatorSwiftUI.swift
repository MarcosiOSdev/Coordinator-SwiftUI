//
//  CoordinatorSwiftUI.swift
//  Code-Cocoaheads
//
//  Created by marcos.felipe.souza on 18/07/22.
//

import Foundation
import UIKit
import SwiftUI

class CoordinatorSwiftUI: Coordinator {
    var children: [Coordinator] = []
    
    var viewController: UIViewController?
    
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
        
    func start(animated: Bool, onDismissed: (() -> Void)?) {
        viewController = HelloViewHostingController(message: "Hello View First", coordinator: self)
        if let viewController = viewController {
            router.present(viewController, animated: true, onDismissed: onDismissed)
        }
    }
    
    func dismiss(animated: Bool) {
        router.dismiss(animated: animated)
    }
}

extension CoordinatorSwiftUI: CoordinatorSwiftUIDelegate {}


protocol CoordinatorSwiftUIDelegate: AnyObject {
    func goToHome()
}

extension CoordinatorSwiftUIDelegate where Self: Coordinator {
    func goToHome() {
        self.dismiss(animated: true)
    }
}

class HelloViewHostingController: UIHostingController<HelloView> {    
    public init(message: String, coordinator: CoordinatorSwiftUIDelegate) {
        let view = HelloView(coordinator: coordinator, message: message)
        super.init(rootView: view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init with coder not implemented")
    }
}
