//
//  RecipeData.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 26/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import Foundation

struct RecipeData: Decodable {
    let hits: [Hits]
}

struct Hits: Decodable {
    let recipe: Recipe
}

struct Recipe: Decodable {
    let title: String
    let image: String
    let source: String
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let calories: Double
    let time: Double

    enum CodingKeys: String, CodingKey {
        case title = "label"
        case time = "totalTime"

        case image
        case source
        case url
        case yield
        case ingredientLines
        case calories
    }
}
