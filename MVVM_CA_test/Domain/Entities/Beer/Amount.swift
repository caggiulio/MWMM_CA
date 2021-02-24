//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

import Foundation

struct Amount : Codable {
	let unit : String?
	let value : Double?

	enum CodingKeys: String, CodingKey {
		case unit = "unit"
		case value = "value"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		unit = try values.decodeIfPresent(String.self, forKey: .unit)
		value = try values.decodeIfPresent(Double.self, forKey: .value)
	}
}
