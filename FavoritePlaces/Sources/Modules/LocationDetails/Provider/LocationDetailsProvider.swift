//
//  Created by Alexander Loshakov on 25/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import Foundation

protocol LocationDetailsProviderProtocol {
    func getItem(completion: @escaping (LocationModel?, LocationDetailsProviderError?) -> Void)
}

enum LocationDetailsProviderError: Error {
    case getItemFailed(withError: Error)
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
    func getItem(completion: @escaping (LocationModel?, LocationDetailsProviderError?) -> Void) {
    }
}
