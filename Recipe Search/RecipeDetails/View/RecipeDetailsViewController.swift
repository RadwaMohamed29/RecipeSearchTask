//
//  RecipeDetailsViewController.swift
//  Recipe Search
//
//  Created by Radwa on 25/08/2022.
//

import UIKit

class RecipeDetailsViewController: UIViewController {

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
    
    func setUpScreen(){
        recipeTitle.text = recipeDetails?.label
        let url = URL(string: recipeDetails?.image ?? "")
        recipeImageView.kf.setImage(with: url)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareDataTapped))
    }
    
    func shareData(data: [Any], barButtonItem: UIBarButtonItem?){
        let activityViewController = UIActivityViewController(activityItems: data, applicationActivities: [])
        activityViewController.popoverPresentationController?.barButtonItem = barButtonItem
        present(activityViewController, animated: true, completion: nil)
    }

    @objc func shareDataTapped(){
        guard let recipeURL = recipeDetails?.url else{ return }
        shareData(data: [recipeURL], barButtonItem: navigationItem.rightBarButtonItem)
    }
    @IBAction func recipeWebsiteBtn(_ sender: Any) {
        recipeViewModel.openWebsite(url: recipeDetails?.url ?? "")
    }
}

extension RecipeDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.backgroundConfiguration?.backgroundColor = UIColor.white
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize:24)
        header.textLabel?.frame = header.bounds
        
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
}
