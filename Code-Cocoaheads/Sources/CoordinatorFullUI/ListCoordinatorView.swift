//
//  AnotherCoordinatorView.swift
//  Code-Cocoaheads
//
//  Created by marcos.felipe.souza on 18/07/22.
//

import SwiftUI
import Combine

class ListCoordinatorViewHostingController: UIHostingController<ListCoordinatorView> {
    public init() {
        super.init(rootView: ListCoordinatorView(object: ListCoordinator()))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init with coder not implemented")
    }
}

class ListCoordinator: ObservableObject, Identifiable {
    @Published var listViewModel: ListViewModel!
    @Published var detailCoordinator: DetailCoordinator?

    init() {
        self.listViewModel = .init(coordinator: self)
    }

    func start() -> ListView {
        ListView(viewModel: .init(coordinator: self))
    }
    
    func open(_ item: String) {
        self.detailCoordinator = DetailCoordinator(item: item)
    }
}

struct ListCoordinatorView: View {

    @ObservedObject var object: ListCoordinator

    var body: some View {
        NavigationView {
            ListView(viewModel: object.listViewModel)
                .navigation(item: $object.detailCoordinator) { $0.start() }
        }
    }
}


class ListViewModel: ObservableObject, Identifiable {
    @Published var items = ["Coordinator", "CoordinatorView", "CoordinatorUIKit", "Coordinator Pattern"]
    unowned let coordinator: ListCoordinator
    init(coordinator: ListCoordinator) {
        self.coordinator = coordinator
    }
    func open(_ item: String) {
        coordinator.open(item)
    }
}

struct ListView: View {
    @ObservedObject var viewModel: ListViewModel
    var body: some View {
        List(viewModel.items, id: \.self) { item in
            Text(item).onTapGesture {
                viewModel.open(item)
            }
        }
    }
}
