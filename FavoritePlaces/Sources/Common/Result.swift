//
//  Created by Alexander Loshakov on 20/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
