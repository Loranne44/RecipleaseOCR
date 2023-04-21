//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 17/11/2022.
//

import UIKit
import CoreData
import Alamofire
import AlamofireImage

class FavoriteViewController: UIViewController {
    
    // MARK: - Properties
    var recipleaseDisplay: RecipleaseDisplay?
    private var repository = CoreDataService()
    private var favoriteRecipe: [FavoriteRecipe] = []
    static var cellIndetifier = "FavoriteRecipe"
    let segueIdentifier = "detailsFavoriteRecipe"
    
    // MARK: - Outlets
    @IBOutlet weak var noRecipeFavoritesLabel: UILabel!
    @IBOutlet weak var favoriteRecipesTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRecipes()
        voiceOver(object: favoriteRecipesTableView, message: "Contains \(favoriteRecipe.count) recipes in your list")
        noRecipeFavoritesLabel.isHidden = favoriteRecipe.isEmpty ? false : true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteRecipesTableView.delegate = self
        favoriteRecipesTableView.dataSource = self
    }
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let successVC = segue.destination as? DetailsRecipeViewController
            let detailRecipe = sender as? RecipleaseDisplay
            successVC?.recipleaseDisplay = detailRecipe
        }
    }
    
    private func  getRecipes() {
        repository.getRecipes(callback: { [weak self] recipes in
            self?.favoriteRecipe = recipes
            self?.favoriteRecipesTableView.reloadData()
        })
    }
}

// MARK: - Extension TableView
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteViewController.cellIndetifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.favoriteRecipe = favoriteRecipe[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = favoriteRecipe[indexPath.row]
        
        let recipeDisplay = RecipleaseDisplay(label: recipe.label ?? "",
                                              image: recipe.image,
                                              uri: recipe.uri ?? "",
                                              url: recipe.url ?? "",
                                              ingredients: recipe.ingredientLines ?? [""],
                                              totalTime: recipe.totalTime,
                                              yield: NSNumber(value: recipe.yield).intValue)
       
        performSegue(withIdentifier: segueIdentifier, sender: recipeDisplay)
    }
    
    /// Delete cells
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let recipe = favoriteRecipe[indexPath.row]
       
        if editingStyle == .delete {
            favoriteRecipe.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            repository.unsaveRecipe(uri: recipe.uri ?? "") {
                self.getRecipes()
            }
        }
        
        favoriteRecipesTableView.reloadData()
        noRecipeFavoritesLabel.isHidden = favoriteRecipe.isEmpty ? false : true
    }
}
