//
//  RecipeAPIClient.swift
//  APIKeys-Recipies
//
//  Created by C4Q  on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class RecipeAPIClient {
    private init() {}
    static let manager = RecipeAPIClient()
    func getRecipes(named searchStr: String,
                    completionHandler: @escaping ([Recipe]) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        let appID = "d1b5d9d8"
        let appKey = "71a137b17f34222b93247e3e0a01eb71"
        let urlStr = "https://api.edamam.com/search?q=\(searchStr)&app_id=\(appID)&app_key=\(appKey)"
        guard let url = URL(string: urlStr) else {errorHandler(AppError.badURL); return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let recipeInfo = try JSONDecoder().decode(AllRecipeInfo.self, from: data)
                let recipeWrappers = recipeInfo.hits
                let recipes = recipeWrappers.map({$0.recipe})
                completionHandler(recipes)
            }
            catch let error {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
