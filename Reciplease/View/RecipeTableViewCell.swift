//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 08/12/2022.
//

import UIKit
import Alamofire
import AlamofireImage

class RecipeTableViewCell: UITableViewCell {
    let recipleaseImageSrvice = RecipleaseImageService()
    //MARK: - Outlets
    
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var imageRecipeView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        voiceOver(object: titleRecipeLabel, message: "Title recipe \(String(describing: titleRecipeLabel))")
        voiceOver(object: ingredientsLabel, message: "List ingredients for recipe \(String(describing: ingredientsLabel))")
        voiceOver(object: yieldLabel, message: "For how many people is the recipe")
        voiceOver(object: imageRecipeView, message: "Photo of the recipe \(String(describing: titleRecipeLabel))")
        voiceOver(object: timeLabel, message: "Time of execution of the recipe")
    }
    
    var recipeResult: Hit? {
        didSet {
            guard let recipe = recipeResult?.recipe else {
                return
            }
            
            titleRecipeLabel.text = recipe.label
            ingredientsLabel.text = recipe.ingredients[0].food
            yieldLabel.text = String(describing: recipe.yield ?? 0)
            timeLabel.text = ((recipe.totalTime ?? 0) * 60).convertTime(style: .abbreviated)
            recipleaseImageSrvice.request(image: recipe.image, object: imageRecipeView)
        }
    }
    
    var favoriteRecipe: FavoriteRecipe? {
        didSet {
            titleRecipeLabel.text = favoriteRecipe?.label
            guard let ingredient = favoriteRecipe?.ingredientLines?.joined(separator: ",") else {
                return
            }
            ingredientsLabel.text = "\(ingredient)"
            yieldLabel.text = String(describing: favoriteRecipe?.yield ?? 0)
            timeLabel.text = ((favoriteRecipe?.totalTime ?? 0) * 60).convertTime(style: .abbreviated)
            recipleaseImageSrvice.request(image: favoriteRecipe?.image, object: imageRecipeView)
        }
    }
}
