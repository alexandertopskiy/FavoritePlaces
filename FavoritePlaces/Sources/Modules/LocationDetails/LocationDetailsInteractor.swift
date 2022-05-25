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

// MARK: -  LocationBusinessLogic

extension LocationDetailsInteractor: LocationDetailsBusinessLogic {
    func fetchItemDetails(request: LocationDetails.ShowItem.Request) {
        
    }
}
