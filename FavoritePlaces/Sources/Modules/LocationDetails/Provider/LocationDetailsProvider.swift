//
//  Created by Alexander Loshakov on 25/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import Foundation

protocol LocationDetailsProviderProtocol {
    func getItem(withId id: UniqueIdentifier, completion: @escaping (LocationModel?, LocationDetailsProviderError?) -> Void)
}

enum LocationDetailsProviderError: Error {
    case getItemFailed(withError: Error)

    var associatedValue: Error {
        switch self {
        case .getItemFailed(let withError):
            return withError
        }
    }
}

struct LocationDetailsProvider {
    let dataStore: LocationsDataStoreProtocol

    // MARK: -  Lifecycle

    init(dataStore: LocationsDataStoreProtocol = LocationsDataStore.shared) {
        self.dataStore = dataStore
    }
}

// MARK: -  LocationDetailsProviderProtocol

extension LocationDetailsProvider: LocationDetailsProviderProtocol {
    func getItem(withId id: UniqueIdentifier, completion: @escaping (LocationModel?, LocationDetailsProviderError?) -> Void) {
        if dataStore.models?.isEmpty == false {
            let model = dataStore.models?.first(where: { $0.uid == id })
            return completion(model, nil)
        }
        return completion(nil, nil)
    }
}
