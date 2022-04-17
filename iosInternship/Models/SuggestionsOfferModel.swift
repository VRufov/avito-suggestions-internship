//
//  SuggestionsOfferModel.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/12/22.
//

import Foundation

struct SuggestionsOfferModel: Decodable, Identifiable {
    let id: String
    let title: String
    let description: String?
    let icon: SuggestionsIcon
    let price: String
    let isSelected: Bool
}
