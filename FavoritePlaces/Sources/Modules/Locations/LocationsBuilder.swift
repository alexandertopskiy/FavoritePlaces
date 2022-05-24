//
//  Created by Alexander Loshakov on 20/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

final class LocationsBuilder: ModuleBuilder {
    var title: String?

    func setTitle(_ title: String) -> Self {
        self.title = title
        return self
    }

    func build() -> UIViewController {
        guard let title = title else {
            fatalError("You should set a title")
        }
        let presenter = LocationsPresenter()
        let interactor = LocationsInteractor(presenter: presenter)
        let controller = LocationsViewController(
            title: title,
            interactor: interactor,
            initialState: .loadingAll
        )
        presenter.viewController = controller
        return controller
    }
}
