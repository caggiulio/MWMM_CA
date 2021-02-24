//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

import Foundation

struct Hops : Codable {
	let attribute : String?
	let amount : Amount?
	let add : String?
	let name : String?

	enum CodingKeys: String, CodingKey {
		case attribute = "attribute"
		case amount = "amount"
		case add = "add"
		case name = "name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		attribute = try values.decodeIfPresent(String.self, forKey: .attribute)
		amount = try values.decodeIfPresent(Amount.self, forKey: .amount)
		add = try values.decodeIfPresent(String.self, forKey: .add)
		name = try values.decodeIfPresent(String.self, forKey: .name)
	}
}
