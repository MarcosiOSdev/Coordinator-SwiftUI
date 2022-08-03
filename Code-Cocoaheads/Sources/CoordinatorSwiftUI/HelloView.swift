//
//  HelloView.swift
//  Code-Cocoaheads
//
//  Created by marcos.felipe.souza on 18/07/22.
//

import SwiftUI

struct HelloView: View {
    
    weak var coordinator: CoordinatorSwiftUIDelegate?
    
    var message: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(message).padding()
            
            Button("Ir pra Home") {
                coordinator?.goToHome()
            }.buttonStyle(.bordered)
            Spacer()
        }
        .padding()
    }
}
