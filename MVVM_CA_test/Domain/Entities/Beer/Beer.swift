//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

import Foundation

struct Beer : Codable, Hashable {
    var tagline : String? = nil
    var name : String? = nil
    var target_og : Double? = nil
    var ebc : Double? = nil
    var description : String? = nil
    var ingredients : Ingredients? = nil
    var contributed_by : String? = nil
    var boil_volume : Boil_volume? = nil
    var attenuation_level : Double? = nil
    var ibu : Double? = nil
    var food_pairing : [String]? = nil
    var target_fg : Double? = nil
    var first_brewed : String? = nil
    var abv : Double? = nil
    var image_url : String? = nil
    var brewers_tips : String? = nil
    var id : Double? = nil
    var volume : Volume? = nil
    var method : Method? = nil
    var ph : Double? = nil
    var srm : Double? = nil 
    
    enum CodingKeys: String, CodingKey {
        case tagline = "tagline"
        case name = "name"
        case target_og = "target_og"
        case ebc = "ebc"
        case description = "description"
        case ingredients = "ingredients"
        case contributed_by = "contributed_by"
        case boil_volume = "boil_volume"
        case attenuation_level = "attenuation_level"
        case ibu = "ibu"
        case food_pairing = "food_pairing"
        case target_fg = "target_fg"
        case first_brewed = "first_brewed"
        case abv = "abv"
        case image_url = "image_url"
        case brewers_tips = "brewers_tips"
        case id = "id"
        case volume = "volume"
        case method = "method"
        case ph = "ph"
        case srm = "srm"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        target_og = try values.decodeIfPresent(Double.self, forKey: .target_og)
        ebc = try values.decodeIfPresent(Double.self, forKey: .ebc)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        ingredients = try values.decodeIfPresent(Ingredients.self, forKey: .ingredients)
        contributed_by = try values.decodeIfPresent(String.self, forKey: .contributed_by)
        boil_volume = try values.decodeIfPresent(Boil_volume.self, forKey: .boil_volume)
        attenuation_level = try values.decodeIfPresent(Double.self, forKey: .attenuation_level)
        ibu = try values.decodeIfPresent(Double.self, forKey: .ibu)
        food_pairing = try values.decodeIfPresent([String].self, forKey: .food_pairing)
        target_fg = try values.decodeIfPresent(Double.self, forKey: .target_fg)
        first_brewed = try values.decodeIfPresent(String.self, forKey: .first_brewed)
        abv = try values.decodeIfPresent(Double.self, forKey: .abv)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        brewers_tips = try values.decodeIfPresent(String.self, forKey: .brewers_tips)
        id = try values.decodeIfPresent(Double.self, forKey: .id)
        volume = try values.decodeIfPresent(Volume.self, forKey: .volume)
        method = try values.decodeIfPresent(Method.self, forKey: .method)
        ph = try values.decodeIfPresent(Double.self, forKey: .ph)
        srm = try values.decodeIfPresent(Double.self, forKey: .srm)
    }
    
    static func == (lhs: Beer, rhs: Beer) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
