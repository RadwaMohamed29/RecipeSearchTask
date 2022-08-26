//
//  RecipeSearch.swift
//  Recipe Search
//
//  Created by Radwa on 25/08/2022.
//

import Foundation
struct Recipe: Codable{
    var hits: [RecipeSearch]?
}
struct RecipeSearch: Codable{
    var recipe: RecipeData?

}
struct RecipeData: Codable{
    let label: String?
    let url: String?
    let image: String?
    let source: String?
    let healthLabels: [String]?
    let ingredientLines: [String]?

}

