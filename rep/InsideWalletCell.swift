//
//  InsideWalletCell.swift
//  rep
//
//  Created by MacBook Pro on 17/10/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit

class InsideWalletCell: UITableViewCell {
    
    @IBOutlet weak var modifiers: UILabel!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        img.clipsToBounds = true
        
        viewImage.clipsToBounds = false
        viewImage.layer.shadowColor = UIColor.black.cgColor
        viewImage.layer.shadowOpacity = 0.6
        viewImage.layer.shadowOffset = CGSize.zero
        viewImage.layer.shadowRadius = 7
        viewImage.layer.shadowPath = UIBezierPath(roundedRect: viewImage.bounds, cornerRadius: 10).cgPath
        
        
        // imgObj.layer.cornerRadius = imgObj.frame.height / 2
        // imgObj.clipsToBounds = true
        
    }
}
