//
//  SuggestionsBannerModel.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/12/22.
//

import Foundation

struct SuggestionsResultModel: Decodable {
    let title: String
    let actionTitle: String
    let selectedActionTitle: String
    let list: [SuggestionsOfferModel]
}
