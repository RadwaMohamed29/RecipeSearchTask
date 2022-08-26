//
//  EndPoints.swift
//  Recipe Search
//
//  Created by Radwa on 24/08/2022.
//

import Foundation

enum EndPoints{
    case recipeSearch(searchText: String)
    case recipesFilter(searchText: String, healthText: String)
    
    var path: String{
        switch self{
        case .recipeSearch(searchText: let text):
            return "q=\(text)%20&app_id=0bf8ebea&app_key=3d128a8b6e996e2349b21ebd36412be2"
        case .recipesFilter(searchText: let text, healthText: let health):
            return "q=\(text)%20&app_id=0bf8ebea&app_key=3d128a8b6e996e2349b21ebd36412be2&health=\(health)"
        }
    }
    
}
