//
//  SuggectionsBannerModel.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/12/22.
//

import Foundation

struct SuggectionsResultModel: Decodable {
    let title: String
    let actionTitle: String
    let selectedActionTitle: String
    let list: [SuggectionsOfferModel]
}
