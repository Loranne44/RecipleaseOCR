//
//  ResultListRecipeViewController.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 17/11/2022.
//

import UIKit
import Alamofire
import AlamofireImage

class ResultListRecipeViewController: UIViewController {
    
    // MARK: - Properties
    var recipleaseSearch: Reciplease!
    var recipleaseDisplay: RecipleaseDisplay?
    
    static var cellIdentifier = "ResultSearchRecipe"
    let segueIdentifier = "DetailRecipe"
    
    // MARK: - Outlets
    @IBOutlet weak var recipeTableView: UITableView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let successVC = segue.destination as? DetailsRecipeViewController
            let detailRecipe = sender as? RecipleaseDisplay
            successVC?.recipleaseDisplay = detailRecipe
        }
    }
}

// MARK: - Extension TableView
extension ResultListRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Configure lines in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipleaseSearch.hits.count
    }
    /// Configure cell format
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultListRecipeViewController.cellIdentifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.recipeResult = recipleaseSearch?.hits[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipleaseSearch.hits[indexPath.row].recipe
        
        let recipeDisplay = RecipleaseDisplay(label: recipe.label,
                                              image: recipe.image,
                                              uri: recipe.uri,
                                              url: recipe.url,
                                              ingredients: recipe.ingredientLines,
                                              totalTime: recipe.totalTime,
                                              yield: recipe.yield)
        performSegue(withIdentifier: segueIdentifier, sender: recipeDisplay)
    }
}
