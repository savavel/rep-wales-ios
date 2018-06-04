//
//  cellDrinks1.swift
//  rep
//
//  Created by MacBook Pro on 31/08/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import Hero

class cellPromotionFeedClient: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var oldPrice: UILabel!
    
    @IBOutlet weak var newPrice: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     self.img.layer.borderWidth = 1
     self.img.layer.borderColor = UIColor.white.cgColor
        
        img.layer.cornerRadius = 5
        img.layer.masksToBounds = true

    }

    
}
