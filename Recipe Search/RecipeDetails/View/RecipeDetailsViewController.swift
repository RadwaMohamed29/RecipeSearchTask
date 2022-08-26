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
    var recipeDetails: RecipeData?
    var recipeViewModel: RecipesViewModelType = RecipeSearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientLinesTableView.register(UINib(nibName: "IngredientLinesTableViewCell", bundle: nil), forCellReuseIdentifier: "IngredientLinesTableViewCell")
        ingredientLinesTableView.dataSource = self
        ingredientLinesTableView.delegate = self
        self.title = "Recipes Details"
        setUpScreen()

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetails?.ingredientLines?.count ?? 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recipe IngredientLines"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ingredientLinesTableView.dequeueReusableCell(withIdentifier: "IngredientLinesTableViewCell", for: indexPath) as? IngredientLinesTableViewCell
        else{
            return UITableViewCell()
        }
        cell.ingredientLinesLbl.text = recipeDetails?.ingredientLines?[indexPath.row]
        return cell
    }
    func setUpScreen(){
        recipeTitle.text = recipeDetails?.label
        let url = URL(string: recipeDetails?.image ?? "")
        recipeImageView.kf.setImage(with: url)
    }

    @IBAction func recipeWebsiteBtn(_ sender: Any) {
        recipeViewModel.openWebsite(url: recipeDetails?.url ?? "")
    }
}
