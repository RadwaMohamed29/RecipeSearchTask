//
//  RecipesSearchViewController.swift
//  Recipe Search
//
//  Created by Radwa on 24/08/2022.
//

import UIKit
import Kingfisher
import KRProgressHUD

class RecipesSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
   
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recipeTableView: UITableView!
    var recipesViewModel: RecipesViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        recipesViewModel = RecipeSearchViewModel()
        self.title = "Recipes Search"
        emptyImageView.image = UIImage(named: "searchImage")
        recipeTableView.isHidden = true
        //getRecipesData()
        

    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        if !(searchBar.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
//            let searchText = searchBar.text?.replacingOccurrences(of: "", with: "%20")
//            getRecipesData(text: searchText ?? "")
//            searchBar.resignFirstResponder()
//        }
//    }
//

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesViewModel?.recipesData?.hits?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
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
        let arr = item?.healthLabels?[0].map { (double) -> String in
            return String(double)
        }.joined()
        cell.recipeHealthLbl.text = arr
        cell.view.layer.borderColor = UIColor.black.cgColor
        cell.view.layer.borderWidth = 1


        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let recipeDetailsVC = storyboard?.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as? RecipeDetailsViewController{
            recipeDetailsVC.recipeDetails = recipesViewModel?.recipesData?.hits?[indexPath.row].recipe
            navigationController?.pushViewController(recipeDetailsVC, animated: true)
            
        }
      
        
    }
    @IBAction func AllRecipesBtn(_ sender: Any) {
        emptyImageView.isHidden = true
        recipesViewModel?.callFuncToGetAllRecipes(searchText: searchBar.text ?? "" , completion: {
            (isFinshed) in
            if !isFinshed {
                KRProgressHUD.show()
            }else{
                KRProgressHUD.dismiss()
            }
        })
        if recipesViewModel?.recipesData?.hits?.count == 0{
            emptyImageView.isHidden = false
            recipeTableView.isHidden = true
            emptyImageView.image = UIImage(named: "noResultImage")
        }else{
            emptyImageView.isHidden = true
            recipeTableView.isHidden = false
            recipesViewModel?.getRecipes = {[weak self ] _ in
            self?.recipeTableView.reloadData()
            }
        }

    }
    
    @IBAction func lowSugerBtn(_ sender: Any) {
       getFilteredData(health: "low-sugar")
    }
    @IBAction func ketoBtn(_ sender: Any) {
        getFilteredData(health: "keto-friendly")
    }
    @IBAction func veganBtn(_ sender: Any) {
       getFilteredData(health: "vegan")
    }
    func getFilteredData(health: String){
        emptyImageView.isHidden = true
        recipesViewModel?.callFuncToGetFilteredRecipes(searchText: searchBar.text ?? "", healthText: health, completion: {
            (isFinshed) in
            if !isFinshed {
                KRProgressHUD.show()
            }else{
                KRProgressHUD.dismiss()
            }
            
        })
        if recipesViewModel?.recipesData?.hits?.count == 0{
            emptyImageView.isHidden = false
            recipeTableView.isHidden = true
            emptyImageView.image = UIImage(named: "noResultImage")
        }else{
            emptyImageView.isHidden = true
            recipeTableView.isHidden = false
            recipesViewModel?.getRecipes = {[weak self ] _ in
            self?.recipeTableView.reloadData()
            }
        }
    }
}
