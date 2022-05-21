//
//  Created by Alexander Loshakov on 20/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

protocol LocationsDisplayLogic: AnyObject {
    func displayItems(viewModel: Locations.ShowItems.ViewModel)
}

protocol LocationsViewControllerDelegate: AnyObject {
    func openLocationDetails(_ locationId: UniqueIdentifier)
}

class LocationsViewController: UIViewController {
    let interactor: LocationBusinessLogic
    var state: Locations.ViewControllerState

    // MARK: -  Lifecycle

    init(title: String, interactor: LocationBusinessLogic, initialState: Locations.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Подменяем базовую вью у контроллера своей кастомной вьюшкой
    override func loadView() {
        let view = LocationsView(frame: UIScreen.main.bounds)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        fetchItems()
    }

    // MARK: -  Private

    private func fetchItems() {
        let request = Locations.ShowItems.Request()
        interactor.fetchItems(request: request)
    }
}

extension LocationsViewController: LocationsDisplayLogic {
    func displayItems(viewModel: Locations.ShowItems.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: Locations.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            print("loading")
        case let .result(items):
            print("result: \n\(items)")
        case .emptyResult:
            print("emptyResult")
        case let .error(message):
            print("error: \(message)")
        }
    }
}
