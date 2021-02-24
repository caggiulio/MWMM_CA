//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

import Foundation

struct Temp : Codable {
	let value : Int?
	let unit : String?

	enum CodingKeys: String, CodingKey {
		case value = "value"
		case unit = "unit"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		value = try values.decodeIfPresent(Int.self, forKey: .value)
		unit = try values.decodeIfPresent(String.self, forKey: .unit)
	}
}
