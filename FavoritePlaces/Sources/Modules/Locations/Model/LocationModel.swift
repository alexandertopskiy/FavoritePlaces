//
//  Created by Alexander Loshakov on 20/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import Foundation

typealias LocationsResponse = [LocationModel]

struct LocationModel: UniqueIdentifiable, Decodable {
    let uid: UniqueIdentifier
    let name: String
    let state: String
    let park: String
    let coordinates: GeoPosition
    let imageName: String
    let isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case uid = "id"
        case name
        case state
        case park
        case coordinates
        case imageName
        case isFavorite
    }
}

struct GeoPosition: Decodable {
    let longitude: Double
    let latitude: Double
}
