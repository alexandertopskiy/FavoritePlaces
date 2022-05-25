//
//  Created by Alexander Loshakov on 25/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

protocol LocationDetailsDisplayLogic: AnyObject {
    func displayItem(viewModel: LocationDetails.ShowItem.ViewModel)
}

final class LocationDetailsViewController: UIViewController {
    let interactor: LocationDetailsBusinessLogic
    var state: LocationDetails.ViewControllerState

    private lazy var customView = self.view as? LocationDetailsView

    // MARK: -  Lifecycle

    init(title: String, interactor: LocationDetailsBusinessLogic, initialState: LocationDetails.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = LocationDetailsView(frame: UIScreen.main.bounds)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        display(newState: state)
    }
}

// MARK: -  LocationsDisplayLogic

extension LocationDetailsViewController: LocationDetailsDisplayLogic {
    func displayItem(viewModel: LocationDetails.ShowItem.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: LocationDetails.ViewControllerState) {
        switch newState {
        case .loading:
            print("loading...")
            customView?.showLoading()
        case let .result(model):
            print("result: \(model)")
        case let .error(message: errorMessage):
            print("error, message: \(errorMessage)")
        }
    }
}
