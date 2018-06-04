//
//  SmallChartTableViewCell.swift
//  rep
//
//  Created by bechir kaddech on 9/17/17.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit

class SmallChartTableViewCell: UITableViewCell {

    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bigContainer: GradiantView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        //clip to bounds this view so it the bottom view can get the bottom corner radius
        bigContainer.layer.cornerRadius = 10
        bigContainer.clipsToBounds = true
        
        self.name.text = "This is a dummy text that it's tested to make sure that things are working perfecty durring the "
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
