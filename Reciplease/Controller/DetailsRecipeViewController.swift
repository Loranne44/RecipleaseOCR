//
//  ResultRecipeViewController.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 17/11/2022.
//

import UIKit
import CoreData
import SafariServices
import Alamofire
import AlamofireImage

class DetailsRecipeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var favorite: UIBarButtonItem!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var imageRecipeView: UIImageView!
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var listIngredients: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonGetDirection: UIButton!
    
    // MARK: - Properties
    let recipleaseImageService = RecipleaseImageService()
    var recipleaseDisplay: RecipleaseDisplay!
    var networkService : CoreDataService? = CoreDataService()
    static var cellIdentifier = "IngredientsDetailCell"
    
    // MARK: - Actions
    @IBAction func buttonGetDirection(_ sender: UIButton) {
        toggleActivityIndicator(activityIndicator: activityIndicator, button: buttonGetDirection, showActivityIndicator: true)
        guard let recipeUrl = URL(string: recipleaseDisplay.url) else {
            return
        }
        let safariVC = SFSafariViewController(url: recipeUrl)
        present(safariVC, animated: true, completion: nil)
        
        toggleActivityIndicator(activityIndicator: activityIndicator, button: buttonGetDirection, showActivityIndicator: false)
    }
    
    // MARK: - Cycle life
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecipe()
        setupImage()
        accessibility()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateFavoriteIcon()
    }
    
    // MARK: - Methods
    /// Setup recipe
    private func setupRecipe() {
        titleRecipeLabel.text = recipleaseDisplay.label
        timeLabel.text = ((recipleaseDisplay.totalTime ?? 0) * 60).convertTime(style: .abbreviated)
        guard let note = recipleaseDisplay.yield else {
            return
        }
        yieldLabel.text = String(note)
    }
    
    /// Setup image
    private func setupImage() {
        recipleaseImageService.request(image: recipleaseDisplay.image, object: imageRecipeView)
    }
    
    // MARK: - CoreData
    private func updateFavoriteIcon() {
        guard networkService?.isExist(recipeUri: recipleaseDisplay?.uri ?? "") == true
        else {
            favorite.image = UIImage(named: "empty-star")
            return
        }
        favorite.image = UIImage(named: "full-star")
    }
    
    /// adding recipes to coredata
    private func addRecipeToFavorites() {
        guard let label = recipleaseDisplay?.label,
              let image = recipleaseDisplay.image,
              let ingredientLines = recipleaseDisplay?.ingredients,
              let yield = recipleaseDisplay.yield,
              let totalTime = recipleaseDisplay.totalTime,
              let uri = recipleaseDisplay?.uri,
              let url = recipleaseDisplay?.url else {
            return
        }
        
        networkService?.saveRecipes(label: label,
                                    image: image,
                                    ingredientLines: ingredientLines,
                                    yield: yield,
                                    totalTime: totalTime,
                                    uri: uri,
                                    url: url,
                                    callback: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
    }
    
    @IBAction func favoriteButton(_ sender: UIBarButtonItem) {
        
        // Recipe isn't in favorite recipe and add list
        if sender.image == UIImage(named: "empty-star") {
            sender.image = UIImage(named: "full-star")
            messageAlert(message: "The recipe has been added to your favorites", title: "Congrats !")
            addRecipeToFavorites()
            
            // Recipe is in favorite recipe and delete list
        } else if sender.image == UIImage(named: "full-star") {
            sender.image = UIImage(named: "empty-star")
            self.messageAlert(message: "The recipe has been removed from your favorites", title: "Congrats !")
            guard let uri = recipleaseDisplay?.uri else {
                return messageAlert(message: ErrorCase.noUri.message, title: "Error")
            }
            
            networkService?.unsaveRecipe(uri: uri,
                                         callback: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
                
            })
        }
    }
    
    func accessibility() {
        voiceOver(object: favorite, message: "Button to add or remove a recipe from the favorites")
        voiceOver(object: timeLabel, message: "Time of execution of the recipe")
        voiceOver(object: yieldLabel, message: "For how many people is the recipe")
        voiceOver(object: imageRecipeView, message: "Photo of the recipe \(String(describing: titleRecipeLabel))")
        voiceOver(object: titleRecipeLabel, message: "Title recipe \(String(describing: titleRecipeLabel))")
        voiceOver(object: listIngredients, message: "Liste ingredients for recipe \(String(describing: listIngredients))")
        voiceOver(object: buttonGetDirection, message: "Button get direction")
    }
}

// MARK: - Extension TableView
extension DetailsRecipeViewController: UITableViewDataSource {
    
    /// Configure lines in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipleaseDisplay.ingredients.count
    }
    
    /// Configure cell format
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipeDisplay = recipleaseDisplay else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsRecipeViewController.cellIdentifier, for: indexPath)
        let ingredient = recipeDisplay.ingredients[indexPath.row]
        cell.textLabel?.text = "- \(String(describing: ingredient))"
        return cell
    }
}
