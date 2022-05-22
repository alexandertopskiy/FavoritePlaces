//
//  Created by Alexander Loshakov on 21/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import Foundation

protocol LocationsServiceProtocol {
    func fetchItems(completion: @escaping ([LocationModel]?, Error?) -> Void)
}

final class LocationsService: LocationsServiceProtocol {
    let decoder: JSONDecoder

    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    func fetchItems(completion: @escaping ([LocationModel]?, Error?) -> Void) {
        if let data = readLocalJSONFile(forName: "landmarkData") {
            let models = parseSuccessData(data: data)
            completion(models, nil)
        }
    }

    private func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }

    private func parseSuccessData(data: Data) -> [LocationModel]? {
        do {
            let models = try decoder.decode(LocationsResponse.self, from: data)
            return models
        } catch {
            return nil
        }
    }
}
