//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

import Foundation

private struct DummyCodable: Codable {} //<-- Dummy hack

struct Beers : Codable {
    var beers : [Beer]?
    
    init(from decoder: Decoder) throws {
        var beers = [Beer]()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            if let beer = try? container.decodeIfPresent(Beer.self) {
                beers.append(beer)
                //print("no trick")
            }
            else {
                _ = try? container.decode(DummyCodable.self) // <-- TRICK
                //print("trick")
            }
        }
        self.beers = beers
    }
}
