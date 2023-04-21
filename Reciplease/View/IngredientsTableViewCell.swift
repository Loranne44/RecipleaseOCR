//
//  IngredientsTableViewCell.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 30/11/2022.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleIngredients: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    /// Configure Ingredients'cell
    func configure(ingredients: String) {
        titleIngredients.text = "- \(ingredients)"
        titleIngredients.textColor = .white
    }
    
}
