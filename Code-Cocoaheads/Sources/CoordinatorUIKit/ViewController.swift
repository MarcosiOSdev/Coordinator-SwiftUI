//
//  ViewController.swift
//  Code-Cocoaheads
//
//  Created by marcos.felipe.souza on 18/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    var coordinator: CoordinatorUIKitDelegate?
    
    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Primeira Navegação", for: .normal)
        button.accessibilityValue = "first"
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        button.backgroundColor = .black
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Segunda Navegação", for: .normal)
        button.accessibilityValue = "second"
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        button.backgroundColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "First Controller"
        view.backgroundColor = .white
        
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        NSLayoutConstraint.activate([
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 16),
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc
    func didTapButton(_ button: UIButton) {
        
        switch button.accessibilityValue {
        case "first": coordinator?.didTapFirstElement()
        case "second": coordinator?.didTapSecondElement()
        default: break
        }
    }
    
}

