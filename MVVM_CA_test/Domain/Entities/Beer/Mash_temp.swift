//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

import Foundation

struct Mash_temp : Codable {
	let duration : Int?
	let temp : Temp?

	enum CodingKeys: String, CodingKey {
		case duration = "duration"
		case temp = "temp"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		duration = try values.decodeIfPresent(Int.self, forKey: .duration)
		temp = try values.decodeIfPresent(Temp.self, forKey: .temp)
	}
}
