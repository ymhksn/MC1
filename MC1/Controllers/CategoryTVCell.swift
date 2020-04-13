//
//  CategoryTVCell.swift
//  MC1
//
//  Created by Yohanes Markus Heksan on 11/04/20.
//  Copyright © 2020 Yohanes Markus Heksan. All rights reserved.
//

import UIKit

class CategoryTVCell: UITableViewCell {

    
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categorySelectIcon: UIImageView!
    @IBOutlet weak var categoryColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        categoryColor.layer.cornerRadius = categoryColor.frame.size.height/3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
