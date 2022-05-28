//
//  Created by Alexander Loshakov on 25/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

protocol LocationDetailsBusinessLogic {
    func fetchItemDetails(request: LocationDetails.ShowItem.Request)
}

final class LocationDetailsInteractor {
    let presenter: LocationDetailsPresentationLogic
    let provider: LocationDetailsProviderProtocol

    // MARK: -  Lifecycle

    init(presenter: LocationDetailsPresentationLogic, provider: LocationDetailsProviderProtocol = LocationDetailsProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
}

// MARK: -  LocationDetailsBusinessLogic

extension LocationDetailsInteractor: LocationDetailsBusinessLogic {
    func fetchItemDetails(request: LocationDetails.ShowItem.Request) {
        provider.getItem(withId: request.uid) { (item, error) in
            let result: Result<LocationModel>
            if let item = item {
                result = .success(item)
            } else {
                result = .failure(LocationDetails.ShowItem.Response.Error.someError)
            }
            self.presenter.presentItem(response: .init(result: result))
        }
    }
}
