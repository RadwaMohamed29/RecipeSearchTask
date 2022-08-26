//
//  NetworkServiceProtocol.swift
//  Recipe Search
//
//  Created by Radwa on 24/08/2022.
//

import Foundation
protocol NetworkServiceProtocol{
    
    func getAllRecipes(recipeText: String,completion: @escaping(Result<Recipe,Error>) -> Void)
    func getFilteredRecipes(recipeText: String,healthText: String,completion: @escaping(Result<Recipe,Error>) -> Void)
}
