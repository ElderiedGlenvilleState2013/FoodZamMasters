//
//  RecipeCell.swift
//  FoodZam
//
//  Created by dadDev on 7/30/20.
//  Copyright © 2020 dadDev. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipeDescLbl: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
