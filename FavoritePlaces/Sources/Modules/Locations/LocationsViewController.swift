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

final class LocationsViewController: UIViewController {
    let interactor: LocationBusinessLogic
    let router: LocationNavigationLogic
    var state: Locations.ViewControllerState

    var tableDataSource: LocationsTableDataSource = .init()
    var tableDelegate: LocationsTableDelegate = .init()

    private lazy var customView = self.view as? LocationsView

    // MARK: -  Lifecycle

    init(title: String,
         interactor: LocationBusinessLogic,
         router: LocationNavigationLogic,
         initialState: Locations.ViewControllerState = .loadingAll) {
        self.interactor = interactor
        self.router = router
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
        tableDelegate.delegate = self
        self.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = LocationsView(
            frame: UIScreen.main.bounds,
            switchDelegate: self
        )
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        display(newState: state)
    }

    // MARK: -  Private

    private func fetchItems(isFavoriteOnly: Bool) {
        let request = Locations.ShowItems.Request(isFavorite: isFavoriteOnly)
        interactor.fetchItems(request: request)
    }
}

// MARK: -  LocationsDisplayLogic

extension LocationsViewController: LocationsDisplayLogic {
    func displayItems(viewModel: Locations.ShowItems.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: Locations.ViewControllerState) {
        state = newState
        switch state {
        case .loadingAll:
            customView?.showLoading()
            fetchItems(isFavoriteOnly: false)
        case .loadingFavorites:
            customView?.showLoading()
            fetchItems(isFavoriteOnly: true)
        case let .result(items):
            tableDelegate.representableViewModels = items
            tableDataSource.representableViewModels = items
            customView?.updateTableViewData(delegate: tableDelegate, dataSource: tableDataSource)
        case let .error(message):
            customView?.showError(message: message)
        }
    }
}

// MARK: -  LocationsViewControllerDelegate

extension LocationsViewController: LocationsViewControllerDelegate {
    func openLocationDetails(_ locationId: UniqueIdentifier) {
        router.pushLocationDetailsModule(withId: locationId)
    }
}

// MARK: -  LocationsPreferencesViewDelegate

extension LocationsViewController: LocationsPreferencesViewDelegate {
    func switchValueChanged(_ isOn: Bool) {
        if isOn {
            display(newState: .loadingFavorites)
        } else {
            display(newState: .loadingAll)
        }
    }
}
