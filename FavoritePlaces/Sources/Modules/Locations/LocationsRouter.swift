//
//  Created by Alexander Loshakov on 20/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

protocol LocationNavigationLogic {
    func pushLocationDetailsModule(withId locationId: UniqueIdentifier)
}

final class LocationsRouter {
    weak var viewController: LocationsViewController?
}

// MARK: -  LocationNavigationLogic

extension LocationsRouter: LocationNavigationLogic {
    func pushLocationDetailsModule(withId locationId: UniqueIdentifier) {
        let detailsController = LocationDetailsBuilder()
            .set(initialState: .initial(id: locationId))
            .build()
        viewController?.navigationController?.pushViewController(detailsController, animated: true)
    }
}
