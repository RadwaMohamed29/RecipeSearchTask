//
//  APIClient.swift
//  Recipe Search
//
//  Created by Radwa on 24/08/2022.
//

import Foundation
import Alamofire

class ApiClient: NetworkServiceProtocol{
 
    
    private let BASE_URL = "https://api.edamam.com/search?"

    func getAllRecipes(recipeText: String, completion: @escaping (Result<Recipe, Error>) -> Void) {
        fetchData(endpoint: .recipeSearch(searchText: recipeText), completion: completion)
    }
    
    func fetchData<T :Codable>(endpoint: EndPoints, completion: @escaping (Result<T, Error>)-> Void){
        let url = "\(BASE_URL)\(endpoint.path)"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response{ res in
            switch res.result{
            case .failure(let error):
                completion(.failure(error))
            case .success(_):
                guard let data = res.data else{return}
                do{
                    let json = try JSONDecoder().decode(T.self, from: data)
                    print("fromNnnnnnnnn\(json)")
                    completion(.success(json))
                }catch let error{
                    completion(.failure(error))
                }
            }
            
        }

    }
 
  
}
