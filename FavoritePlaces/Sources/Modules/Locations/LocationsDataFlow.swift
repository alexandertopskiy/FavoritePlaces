//
//  Created by Alexander Loshakov on 20/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

enum Locations {
    enum ShowItems {
        struct Request {
            let isFavorite: Bool
        }

        struct Response {
            var result: Result<[LocationModel]>

            enum Error: Swift.Error, LocalizedError {
                case fetchError
                case parsingError
                case notFound
                case someError

                var errorDescription: String? {
                    switch self {
                    case .fetchError:
                        return "Error loading data"
                    case .parsingError:
                        return "Data is invalid!"
                    case .notFound:
                        return "Nothing Found! Data is empty!"
                    case .someError:
                        return "Something went wrong..."
                    }
                }
            }
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }

    enum ViewControllerState {
        case loadingAll
        case loadingFavorites
        case result([LocationViewModel])
        case emptyResult(title: String, subtitle: String)
        case error(message: String)
    }
}
