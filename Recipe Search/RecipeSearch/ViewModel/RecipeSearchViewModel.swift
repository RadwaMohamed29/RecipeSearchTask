//
//  RecipeSearchViewModel.swift
//  Recipe Search
//
//  Created by Radwa on 25/08/2022.
//

import Foundation
protocol RecipesViewModelType{
    func callFuncToGetAllRecipes(completion: @escaping(Bool)-> Void)
    var getRecipes: ((RecipesViewModelType)-> Void)? {get set}
    var recipesData: Recipe? {get set}
}
class RecipeSearchViewModel: RecipesViewModelType{
    var network = ApiClient()
    var getRecipes: ((RecipesViewModelType) -> Void)?
    
    var recipesData: Recipe?{
        didSet{
            getRecipes?(self)
        }
    }
    func callFuncToGetAllRecipes(completion: @escaping (Bool) -> Void) {
        completion(false)
        network.getAllRecipes(recipeText: "chicken") { [weak self]
            result in
            switch result{
            case .success(let recipes):
                self?.recipesData = recipes
                
            case .failure(_):
                print("can not fetch data")
            }
            
        }
        completion(true)
    }
    

    
    
}
