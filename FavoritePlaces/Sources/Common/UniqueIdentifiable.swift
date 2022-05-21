//
//  Created by Alexander Loshakov on 20/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

typealias UniqueIdentifier = Int

/// Протокол определяющий поведение объектов идентфицируемых уникально
protocol UniqueIdentifiable {
    var uid: UniqueIdentifier { get }
}
