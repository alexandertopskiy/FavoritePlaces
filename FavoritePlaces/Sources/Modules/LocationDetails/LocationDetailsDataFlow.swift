//
//  Created by Alexander Loshakov on 25/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import Foundation

enum LocationDetails {
    enum ShowItem {
        struct Request {}

        struct Response {
            var result: Result<LocationModel>

            enum Error: Swift.Error {
                case someError
            }
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }

    enum ViewControllerState {
        case loading
        case result(LocationDetailsViewModel)
        case error(message: String)
    }
}
