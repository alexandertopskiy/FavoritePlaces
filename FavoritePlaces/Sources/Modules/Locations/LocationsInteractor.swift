//
//  Created by Alexander Loshakov on 20/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

protocol LocationBusinessLogic {
    func fetchItems(request: Locations.ShowItems.Request)
}

class LocationsInteractor: LocationBusinessLogic {
     let presenter: LocationPresentationLogic
     let provider: LocationsProviderProtocol

    // MARK: -  Lifecycle

    init(presenter: LocationPresentationLogic, provider: LocationsProviderProtocol = LocationsProvider()) {
        self.presenter = presenter
        self.provider = provider
    }

    // MARK: -  Fetching

    func fetchItems(request: Locations.ShowItems.Request) {
        provider.getItems { (items, error) in
            let result: Result<[LocationModel]>
            if let items = items {
                result = .success(items)
            } else {
                result = .failure(Locations.ShowItems.Response.Error.fetchError)
            }
            self.presenter.presentItems(response: .init(result: result))
        }
    }
}
