//
//  RecipeSearchViewModel.swift
//  Recipe Search
//
//  Created by Radwa on 25/08/2022.
//

import Foundation
import UIKit
protocol RecipesViewModelType{
    func callFuncToGetAllRecipes(searchText:String, completion: @escaping(Bool)-> Void)
    var getRecipes: ((RecipesViewModelType)-> Void)? {get set}
    var recipesData: Recipe? {get set}
    func openWebsite(url: String)
}
class RecipeSearchViewModel: RecipesViewModelType{
    
    func openWebsite(url: String) {
        let application = UIApplication.shared
        if application.canOpenURL(URL(string: url)!){
            application.open(URL(string: url)!)
        }else{
            application.open(URL(string: "https://\(url)")!)

        }
    }
    
    var network = ApiClient()
    var getRecipes: ((RecipesViewModelType) -> Void)?
    
    var recipesData: Recipe?{
        didSet{
            getRecipes?(self)
        }
    }
    func callFuncToGetAllRecipes(searchText:String, completion: @escaping (Bool) -> Void) {
        completion(false)
        network.getAllRecipes(recipeText: searchText) { [weak self]
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
