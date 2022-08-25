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
//    enum CodingKeys: String, CodingKey{
//        case recipe = "recipe"
//    }
}
struct RecipeData: Codable{
    let label: String?
    let url: String?
    let image: String?
    let source: String?
    let healthLabels: [String]?
    let ingredientLines: [String]?
    
//    enum CodingKeys: String, CodingKey{
//        case label = "label"
//        case url = "url"
//        case image = "image"
//        case source = "source"
//        case healthLabels = "healthLabels"
//        case ingredientLines = "ingredientLines"
//    }
}


//struct Countrys: Codable{
//    let idLeague : String
//    let strSport : String
//    let strLeague : String
//    let strCountry : String
//    let strYoutube : String
//    let strBadge : String
//
//    enum CodingKeys : String, CodingKey{
//        case idLeague = "idLeague"
//        case strSport = "strSport"
//        case strLeague = "strLeague"
//        case strCountry = "strCountry"
//        case strYoutube = "strYoutube"
//        case strBadge = "strBadge"
//
//    }
//}
