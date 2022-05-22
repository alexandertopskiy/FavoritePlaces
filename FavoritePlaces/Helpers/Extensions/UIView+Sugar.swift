//
//  Created by Alexander Loshakov on 21/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

extension UIView {
    func setRadius(radius: CGFloat) {
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(self.addSubview)
    }
}
