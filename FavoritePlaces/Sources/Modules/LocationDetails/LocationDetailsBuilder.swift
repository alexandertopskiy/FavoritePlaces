//
//  Created by Alexander Loshakov on 25/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

final class LocationDetailsBuilder: ModuleBuilder {
    var initialState: LocationDetails.ViewControllerState?

    func set(initialState: LocationDetails.ViewControllerState) -> Self {
        self.initialState = initialState
        return self
    }

    func build() -> UIViewController {
        guard let initialState = initialState else {
            fatalError("Initial state parameter was not set")
        }
        let presenter = LocationDetailsPresenter()
        let interactor = LocationDetailsInteractor(presenter: presenter)
        let controller = LocationDetailsViewController(
            interactor: interactor,
            initialState: initialState
        )
        presenter.viewController = controller
        return controller
    }
}
