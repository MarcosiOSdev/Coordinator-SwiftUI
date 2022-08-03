//
//  Router.swift
//  Code-Cocoaheads
//
//  Created by marcos.felipe.souza on 18/07/22.
//

import UIKit

public protocol Router: AnyObject {
    var navigationController: UINavigationController { get }
    func present(_ present: Presentable, animated: Bool)
    func present(_ present: Presentable, animated: Bool, onDismissed: (()->Void)?)
    func dismiss(animated: Bool)    
}

extension Router {
    public func present(_ present: Presentable, animated: Bool) {
        self.present(present, animated: animated, onDismissed: nil)
    }
}
