//
//  Created by Alexander Loshakov on 21/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import Foundation

protocol LocationsProviderProtocol {
    func getItems(completion: @escaping ([LocationModel]?, LocationsProviderError?) -> Void)
}

enum LocationsProviderError: Error {
    case getItemsFailed(withError: Error)

    var associatedValue: Error {
        switch self {
        case .getItemsFailed(let withError):
            return withError
        }
    }
}

struct LocationsProvider {
    let dataStore: LocationsDataStoreProtocol
    let service: LocationsServiceProtocol

    // MARK: -  Lifecycle

    init(dataStore: LocationsDataStoreProtocol = LocationsDataStore.shared, service: LocationsServiceProtocol = LocationsService()) {
        self.dataStore = dataStore
        self.service = service
    }
}

// MARK: -  LocationsProviderProtocol

extension LocationsProvider: LocationsProviderProtocol {
    func getItems(completion: @escaping ([LocationModel]?, LocationsProviderError?) -> Void) {
        if dataStore.models?.isEmpty == false {
            return completion(self.dataStore.models, nil)
        }
        service.fetchItems { (models, error) in
            if let error = error {
                completion(nil, .getItemsFailed(withError: error))
            } else if let models = models {
                self.dataStore.models = models
                completion(self.dataStore.models, nil)
            }
        }
    }
}
