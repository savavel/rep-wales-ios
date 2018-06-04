//
//  TopCollectionViewCell.swift
//  rep
//
//  Created by bechir Kaddech on 8/31/17.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var rounded: UIView!
    @IBOutlet weak var text: UILabel!
    var isSelectedd : Bool = false
    var i : Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rounded.layer.cornerRadius = 20
        rounded.layer.shadowColor = UIColor.blue.cgColor
        rounded.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        rounded.layer.shadowRadius = 3
        rounded.layer.shadowOpacity = 0.3
        
        
        
    }
    
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
