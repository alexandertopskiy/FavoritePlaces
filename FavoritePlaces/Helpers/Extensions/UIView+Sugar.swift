//
//  Created by Alexander Loshakov on 21/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(self.addSubview)
    }
}
