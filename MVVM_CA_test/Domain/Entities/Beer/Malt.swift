//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

import Foundation

struct Malt : Codable {
	let name : String?
	let amount : Amount?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case amount = "amount"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		amount = try values.decodeIfPresent(Amount.self, forKey: .amount)
	}
}
