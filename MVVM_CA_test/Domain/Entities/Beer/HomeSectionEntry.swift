//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

import Foundation

struct HomeSectionEntry: Hashable {
    var beers: [Beer]? = nil
    var categories: [Category]? = nil
    var id = UUID()
    
    static func == (lhs: HomeSectionEntry, rhs: HomeSectionEntry) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
