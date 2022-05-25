//
//  Created by Alexander Loshakov on 25/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

final class LocationDetailsBuilder: ModuleBuilder {
    var title: String?

    func setTitle(_ title: String) -> Self {
        self.title = title
        return self
    }

    func build() -> UIViewController {
        guard let title = title else {
            fatalError("You should set a title")
        }
        let presenter = LocationDetailsPresenter()
        let interactor = LocationDetailsInteractor(presenter: presenter)
        let controller = LocationDetailsViewController(
            title: title,
            interactor: interactor,
            initialState: .loading
        )
        presenter.viewController = controller
        return controller
    }
}
