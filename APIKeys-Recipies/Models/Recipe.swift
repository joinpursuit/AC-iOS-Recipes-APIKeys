//
//  Recipe.swift
//  APIKeys-Recipies
//
//  Created by C4Q  on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct AllRecipeInfo: Codable {
    let hits: [RecipeWrapper]
}

struct RecipeWrapper: Codable {
    let recipe: Recipe
}

struct Recipe: Codable {
    let name: String
    let image: String
    let source: String
    
    enum CodingKeys: String, CodingKey {
        case name = "label"
        case image
        case source
    }
}
