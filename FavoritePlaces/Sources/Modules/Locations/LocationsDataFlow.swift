//
//  Created by Alexander Loshakov on 20/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

enum Locations {
    enum ShowItems {
        struct Request {

        }

        struct Response {
            var result: Result<[LocationModel]>

            enum Error: Swift.Error {
                case fetchError
            }
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }

    enum ViewControllerState {
        case loading
        case result([LocationViewModel])
        case emptyResult(title: String, subtitle: String)
        case error(message: String)
    }
}
