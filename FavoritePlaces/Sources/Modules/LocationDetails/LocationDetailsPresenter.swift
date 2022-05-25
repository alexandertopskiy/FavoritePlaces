//
//  Created by Alexander Loshakov on 25/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit.UIImage

protocol LocationDetailsPresentationLogic {
    func presentItem(response: LocationDetails.ShowItem.Response)
}

final class LocationDetailsPresenter {
    weak var viewController: LocationDetailsDisplayLogic?
    let errorMessage = "Error loading data 💩"
}

extension LocationDetailsPresenter: LocationDetailsPresentationLogic {
    func presentItem(response: LocationDetails.ShowItem.Response) {
        var viewModel: LocationDetails.ShowItem.ViewModel

        switch response.result {
        case let .success(result):
            let location: LocationDetailsViewModel = .init(
                uid: result.uid,
                name: result.name,
                park: result.park,
                state: result.state,
                geoPosition: result.coordinates,
                image: UIImage(named: result.imageName),
                isFavorite: result.isFavorite
            )
            viewModel = .init(state: .result(location))
        case .failure:
            viewModel = .init(state: .error(message: errorMessage))
        }
        viewController?.displayItem(viewModel: viewModel)
    }
}
