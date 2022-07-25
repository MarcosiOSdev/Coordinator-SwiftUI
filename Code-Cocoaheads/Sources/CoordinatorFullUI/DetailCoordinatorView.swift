//
//  AnotherCoordinatorObject.swift
//  Code-Cocoaheads
//
//  Created by marcos.felipe.souza on 18/07/22.
//

import Combine
import SwiftUI

class DetailCoordinator: ObservableObject {
    @Published var viewModel: DetailViewModel!
    init(item: String) {
        viewModel = DetailViewModel(item: item, coordinator: self)
    }
    
    func start() -> some View {
        DetailView(viewModel: viewModel)
    }
}

struct DetailCoordinatorView: View {
    
    @ObservedObject var object: DetailCoordinator
    
    var body: some View {
        DetailView(viewModel: object.viewModel)
    }
}

struct DetailView: View {    
    @ObservedObject var viewModel: DetailViewModel
    var body: some View {
        Text(viewModel.value)
            .onAppear(perform: viewModel.startItem)
    }
}

class DetailViewModel: ObservableObject {
    
    @Published var value: String = ""
    let item: String
    private unowned let coordinator: DetailCoordinator
    init(
        item: String,
        coordinator: DetailCoordinator
    ) {
        self.item = item
        self.coordinator = coordinator
    }
    func startItem() {
        value = "Item selecionado foi = \(item)"
    }
}
