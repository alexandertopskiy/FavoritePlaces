//
//  Created by Alexander Loshakov on 27/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach(self.addArrangedSubview)
    }
}
