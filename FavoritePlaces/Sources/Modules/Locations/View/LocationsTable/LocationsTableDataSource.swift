//
//  Created by Alexander Loshakov on 22/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

final class LocationsTableDataSource: NSObject, UITableViewDataSource {
    var representableViewModels: [LocationViewModel]

    init(viewModels: [LocationViewModel] = []) {
        representableViewModels = viewModels
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        representableViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithRegistration(type: LocationsTableViewCell.self, indexPath: indexPath)
        guard let viewModel = representableViewModels[safe: indexPath.row] else { return cell }
        cell.configure(cellRepresentable: viewModel)
        return cell
    }
}
