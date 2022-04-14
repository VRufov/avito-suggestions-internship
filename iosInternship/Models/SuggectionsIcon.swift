//
//  SuggectionsIcon.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/12/22.
//

import Foundation

struct SuggectionsIcon: Decodable {
    enum CodingKeys: String, CodingKey {
        case imageURL = "52x52"
    }
    let imageURL: String
}
