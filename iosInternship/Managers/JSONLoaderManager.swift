//
//  JSONLoaderManager.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/17/22.
//

import Foundation


class JSONLoader {
    static func loadJSON(fileName: String) -> SuggestionsResponseModel? {
        do {
            let data = try Data(contentsOf: (Bundle.main.url(forResource: fileName, withExtension: "json"))!)
            let result = try JSONDecoder().decode(SuggestionsResponseModel.self, from: data)
            return result
        } catch {
            assertionFailure("JSON loading error: \(error)")
            return nil
        }
    }
}
