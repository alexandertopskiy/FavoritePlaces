//
//  Created by Alexander Loshakov on 25/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

final class LocationsTableDelegate: NSObject, UITableViewDelegate {
    weak var delegate: LocationsViewControllerDelegate?
    var representableViewModels: [LocationViewModel]

    init(viewModels: [LocationViewModel] = []) {
        representableViewModels = viewModels
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        guard let viewModel = representableViewModels[safe: indexPath.row] else {
            return
        }
        delegate?.openLocationDetails(viewModel.uid)
    }
}
