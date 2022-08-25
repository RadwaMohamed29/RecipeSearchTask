//
//  RecipesSearchViewController.swift
//  Recipe Search
//
//  Created by Radwa on 24/08/2022.
//

import UIKit
import Kingfisher
import KRProgressHUD

class RecipesSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var recipeTableView: UITableView!
    var recipesViewModel: RecipesViewModelType? {
        didSet{
            recipesViewModel?.callFuncToGetAllRecipes(completion: {
                (isFinshed) in
                if !isFinshed {
                    KRProgressHUD.show()
                }else{
                    KRProgressHUD.dismiss()
                }
            })
            
            recipesViewModel?.getRecipes = {[weak self ] _ in
                DispatchQueue.main.async {
                    self?.recipeTableView.reloadData()
                }
                
            }
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        recipesViewModel = RecipeSearchViewModel()
        //getRecipesData()

    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("counttt\(recipesViewModel?.recipesData?.hits?.count)")
        return recipesViewModel?.recipesData?.hits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as? RecipeTableViewCell
        else{
            return UITableViewCell()
        }
        let item = recipesViewModel?.recipesData?.hits?[indexPath.row].recipe
        cell.recipeTitleLbl.text = item?.label
        cell.recipeSourceLbl.text = item?.source
        let url = URL(string: item?.image ?? "")
        cell.recipeImage.kf.setImage(with: url)
        cell.recipeSourceLbl.text = item?.healthLabels?[0]

        return cell
    }
    
    func getRecipesData(){
        recipesViewModel?.callFuncToGetAllRecipes(completion: {
            (isFinshed) in
            if !isFinshed {
                KRProgressHUD.show()
            }else{
                KRProgressHUD.dismiss()
            }
        })
    }
}
