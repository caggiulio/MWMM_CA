//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

import Foundation

struct Ingredients : Codable {
	let hops : [Hops]?
	let malt : [Malt]?
	let yeast : String?

	enum CodingKeys: String, CodingKey {
		case hops = "hops"
		case malt = "malt"
		case yeast = "yeast"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		hops = try values.decodeIfPresent([Hops].self, forKey: .hops)
		malt = try values.decodeIfPresent([Malt].self, forKey: .malt)
		yeast = try values.decodeIfPresent(String.self, forKey: .yeast)
	}
}
