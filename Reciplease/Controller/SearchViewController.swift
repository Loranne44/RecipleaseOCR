//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 17/11/2022.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    var ingredients = Set<String>()
    static var cellIdentifier = "IngredientsCell"
    let segueIdentifier = "IngredientsToRecipe"
    
    // MARK: - Loaded View
    override func viewWillAppear(_ animated: Bool) {
        toggleActivityIndicator(activityIndicator: activityIndicator, button: searchRecipesButton, showActivityIndicator: false)
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchRecipesButton: UIButton!
    @IBOutlet weak var nameIngredientTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    
    //MARK: - Configure segue to ResultListRecipeViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultListRecipeViewController,
              let recipe = sender as? Reciplease
        else {
            return
        }
        
        resultVC.recipleaseSearch = recipe
    }
    
    // MARK: - Actions
    @IBAction func buttonAddIngredients(_ sender: UIButton) {
        
        guard let nameIngredient = nameIngredientTextField.text,
              !nameIngredient.isBlank
        else {
            // Modification message erreur
            messageAlert(message: ErrorCase.isEmpty.message, title: "Error")
            return
        }
        
        ingredients.insert(nameIngredient)
        tableView.reloadData()
        nameIngredientTextField.text = ""
        nameIngredientTextField.resignFirstResponder()
    }
    
    @IBAction func clearButton(_ sender: Any) {
        ingredients.removeAll()
        tableView.reloadData()
    }
    
    @IBAction func searchRecipesButton(_ sender: Any) {
        guard ingredients.count >= 1 else { return
            messageAlert(message: ErrorCase.countNotSuffisant.message, title: "Error")
        }
        loadRecipes()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameIngredientTextField.resignFirstResponder()
    }
    
    // MARK: - Methods
    func loadRecipes() {
        toggleActivityIndicator(activityIndicator: activityIndicator,
                                button: searchRecipesButton,
                                showActivityIndicator: true)
        
        RecipleaseService.shared.getRecipes(ingredients: Array(ingredients)) { [weak self] result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(recipe) :
                    self?.performSegue(withIdentifier: self!.segueIdentifier, sender: recipe)
                case let .failure(error):
                    self?.messageAlert(message: "Error", title: "\(error)")
                }
                self?.toggleActivityIndicator(activityIndicator: self!.activityIndicator,
                                              button: self!.searchRecipesButton,
                                              showActivityIndicator: false)
            }
        }
    }
}

// MARK: - Extension TableView
extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    /// Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewController.cellIdentifier, for: indexPath) as? IngredientsTableViewCell else {
            return UITableViewCell()
        }
        
        let ingredientName = ingredients[ingredients.index(from: indexPath.row)]
        cell.configure(ingredients: ingredientName)
        return cell
    }
}

/// Delete row in tableView
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            ingredients.remove(at: ingredients.index(from: indexPath.row))
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
