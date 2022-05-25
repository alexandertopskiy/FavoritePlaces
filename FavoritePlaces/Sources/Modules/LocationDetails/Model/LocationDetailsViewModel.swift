//
//  Created by Alexander Loshakov on 25/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

struct LocationDetailsViewModel {
    let uid: UniqueIdentifier
    let name: String
    let park: String
    let state: String
    let geoPosition: GeoPosition
    let image: UIImage?
    let isFavorite: Bool
}
