//
//  RecipeResponse.swift
//  Recipe Search
//
//  Created by Radwa on 26/08/2022.
//

import Foundation
class RecipeResponse: Codable {
    var hits : [Hit]?
    var _links : Link?
}
class Link: Codable {
    var next : Next?
}
class Next: Codable {
    var href : String?
    var title : String?
}
class Hit: Codable {
    var recipe : RecipeModel?
}
class RecipeModel: Codable {
    var uri : String?
    var label : String?
    var image : String?
    var source : String?
    var url : String?
    var yield : Int?
    var dietLabels: [String]?
    var healthLabels : [String]?
    var cautions : [String]?
    var ingredientLines : [String]?
    var ingredients : [Ingredinet]?
    var calories : Double?
    var totalWeight : Double?
 
}

class Ingredinet : Codable {
    var text : String?
    var weight : Double?
    var foodCategory : String?
    var foodId : String?
    var image : String?
    
}

