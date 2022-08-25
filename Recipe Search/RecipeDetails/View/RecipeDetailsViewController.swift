//
//  RecipeDetailsViewController.swift
//  Recipe Search
//
//  Created by Radwa on 25/08/2022.
//

import UIKit

class RecipeDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ingredientLinesTableView: UITableView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientLinesTableView.register(UINib(nibName: "IngredientLinesTableViewCell", bundle: nil), forCellReuseIdentifier: "IngredientLinesTableViewCell")
        ingredientLinesTableView.dataSource = self
        ingredientLinesTableView.delegate = self

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ingredientLinesTableView.dequeueReusableCell(withIdentifier: "IngredientLinesTableViewCell", for: indexPath) as? IngredientLinesTableViewCell
        else{
            return UITableViewCell()
        }
        return cell
    }
    

    @IBAction func recipeWebsiteBtn(_ sender: Any) {
    }
}
