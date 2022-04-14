//
//  SuggectionsResponseModel.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/12/22.
//

import Foundation

struct SuggectionsResponseModel: Decodable {
    let status: String
    let result: SuggectionsResultModel
}
