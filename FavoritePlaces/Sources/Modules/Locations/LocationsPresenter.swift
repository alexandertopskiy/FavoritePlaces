//
//  Created by Alexander Loshakov on 20/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit.UIImage

protocol LocationPresentationLogic {
    func presentItems(response: Locations.ShowItems.Response)
}

final class LocationsPresenter {
    weak var viewController: LocationsDisplayLogic?

    // MARK: -  Private

    private func viewModels(from models: [LocationModel]) -> [LocationViewModel] {
        var viewModels = [LocationViewModel]()
        models.forEach { model in
            let viewModel = LocationViewModel(
                uid: model.uid,
                title: model.name,
                image: UIImage(named: model.imageName),
                isFavorite: model.isFavorite
            )
            viewModels.append(viewModel)
        }
        return viewModels
    }
}

// MARK: -  LocationPresentationLogic

extension LocationsPresenter: LocationPresentationLogic {
    func presentItems(response: Locations.ShowItems.Response) {
        var viewModel: Locations.ShowItems.ViewModel

        switch response.result {
        case let .success(result):
            let locations = viewModels(from: result)
            viewModel = .init(state: .result(locations))
        case let .failure(error):
            viewModel = .init(state: .error(message: error.localizedDescription))
        }
        viewController?.displayItems(viewModel: viewModel)
    }
}
