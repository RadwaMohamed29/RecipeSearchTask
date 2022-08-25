//
//  RecipesSearchViewController.swift
//  Recipe Search
//
//  Created by Radwa on 24/08/2022.
//

import UIKit

class RecipesSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var recipeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")
        recipeTableView.dataSource = self
        recipeTableView.delegate = self

    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as? RecipeTableViewCell
        else{
            return UITableViewCell()
        }
        cell.layer.cornerRadius = 25

        return cell
    }
    

}
