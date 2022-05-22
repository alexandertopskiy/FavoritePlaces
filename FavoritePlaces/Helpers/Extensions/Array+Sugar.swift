//
//  Created by Alexander Loshakov on 22/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
