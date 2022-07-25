//
//  Presentable.swift
//  Code-Cocoaheads
//
//  Created by marcos.felipe.souza on 18/07/22.
//

import UIKit

public protocol Presentable {
    func toPresent() -> UIViewController
}

extension UIViewController: Presentable {
    public func toPresent() -> UIViewController {
        return self
    }
}
