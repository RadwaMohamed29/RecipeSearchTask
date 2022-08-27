//
//  RecipesSearchViewController.swift
//  Recipe Search
//
//  Created by Radwa on 24/08/2022.
//

import UIKit
import Kingfisher
import KRProgressHUD
import NVActivityIndicatorView

class RecipesSearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recipeTableView: UITableView!
    var recipesViewModel: RecipesViewModelType?
    var indicator = NVActivityIndicatorView(frame: .zero, type: .ballClipRotateMultiple, color: .label , padding: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        recipesViewModel = RecipeSearchViewModel()
        self.title = "Recipes Search"
        emptyImageView.image = UIImage(named: "searchImage")
        recipeTableView.isHidden = true
        searchBar.delegate = self
        
        
    }
    func getRecipesSearchData(){
        emptyImageView.isHidden = true
        recipeTableView.isHidden = true
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        recipesViewModel?.callFuncToGetAllRecipes(searchText: searchBar.text ?? "" , completion: {
                        (isFinshed) in
            
                        if isFinshed {
                            DispatchQueue.main.async {
                                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                                if self.recipesViewModel?.recipesData?.hits?.count == 0{
                                    self.emptyImageView.isHidden = false
                                    self.recipeTableView.isHidden = true
                                    self.emptyImageView.image = UIImage(named: "noResultImage")
                                }else{
                                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                                    self.emptyImageView.isHidden = true
                                    self.recipeTableView.isHidden = false
                                    self.recipesViewModel?.getRecipes = { [weak self] _ in
                                        self?.recipeTableView.reloadData()
                                    }
                                }
                                
                            }
                         
                        }else{
                            self.emptyImageView.isHidden = false
                            self.recipeTableView.isHidden = true
                            self.emptyImageView.image = UIImage(named: "noResultImage")
                        }
                    })
    
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       getRecipesSearchData()
        }
    
   
    func getFilteredData(health: String){
        emptyImageView.isHidden = true
        recipeTableView.isHidden = true
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        recipesViewModel?.callFuncToGetFilteredRecipes(searchText: searchBar.text ?? "", healthText: health, completion:  {
                        (isFinshed) in
            
                        if isFinshed {
                            DispatchQueue.main.async {
                                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                                if self.recipesViewModel?.recipesData?.hits?.count == 0{
                                    self.emptyImageView.isHidden = false
                                    self.recipeTableView.isHidden = true
                                    self.emptyImageView.image = UIImage(named: "noResultImage")
                                }else{
                                    self.emptyImageView.isHidden = true
                                    self.recipeTableView.isHidden = false
                                    self.recipesViewModel?.getRecipes = { [weak self] _ in
                                        self?.recipeTableView.reloadData()
                                    }
                                }
                                
                            }
                         
                        }else{
                            self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                            self.emptyImageView.isHidden = false
                            self.recipeTableView.isHidden = true
                            self.emptyImageView.image = UIImage(named: "noResultImage")
                        }
                    })
    
    }
    @IBAction func AllRecipesBtn(_ sender: Any) {
        getRecipesSearchData()
        
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
    
}


extension RecipesSearchViewController:  UITableViewDataSource, UITableViewDelegate {
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
        cell.recipeHealthLbl.text += "\(String(describing: arr!)) | "
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
}
