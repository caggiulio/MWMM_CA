//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

import Foundation

struct Fermentation : Codable {
	let temp : Temp?

	enum CodingKeys: String, CodingKey {
		case temp = "temp"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		temp = try values.decodeIfPresent(Temp.self, forKey: .temp)
	}
}
