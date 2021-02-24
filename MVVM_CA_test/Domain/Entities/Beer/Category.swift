//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

import Foundation

struct Category: Hashable {
    var category: String? = nil
    var shouldSelect: Bool = false
    var id = UUID()
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
