//
//  Created by Alexander Loshakov on 21/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import Foundation

protocol LocationsDataStoreProtocol: AnyObject {
    var models: [LocationModel]? { get set }
}

class LocationsDataStore: LocationsDataStoreProtocol {
    static let shared = LocationsDataStore()
    var models: [LocationModel]?
}
