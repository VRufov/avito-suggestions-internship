//
//  SuggestionsIcon.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/12/22.
//

import Foundation

struct SuggestionsIcon: Decodable {
    let imageURL: String
}

extension SuggestionsIcon {
    enum CodingKeys: String, CodingKey {
        case imageURL = "52x52"
    }
}
