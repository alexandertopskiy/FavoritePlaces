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
    var state: Locations.ViewControllerState
    var tableDataSource: LocationsTableDataSource = .init()

    private lazy var customView = self.view as? LocationsView

    // MARK: -  Lifecycle

    init(title: String, interactor: LocationBusinessLogic, initialState: Locations.ViewControllerState = .loadingAll) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = LocationsView(
            frame: UIScreen.main.bounds,
            tableDataSouce: tableDataSource,
            refreshDelegate: self,
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
            print("loading all")
            customView?.showLoading()
            fetchItems(isFavoriteOnly: false)
        case .loadingFavorites:
            print("loading Favorites")
            customView?.showLoading()
            fetchItems(isFavoriteOnly: true)
        case let .result(items):
            print("result: \(items.count) items")
            tableDataSource.representableViewModels = items
            customView?.updateTableViewData()
        case let .emptyResult(title, subtitle):
            print("emptyResult")
            customView?.showEmptyView(title: title, subtitle: subtitle)
        case let .error(message):
            print("error: \(message)")
            customView?.showError(message: message)
        }
    }
}

// MARK: -  LocationsErrorViewDelegate

extension LocationsViewController: LocationsErrorViewDelegate {
    func reloadButtonWasTapped() {
        display(newState: .loadingAll)
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
