
    
    //
    //  LiveFeedCollectionViewCell1.swift
    //  rep
    //
    //  Created by MacBook Pro on 30/08/2017.
    //  Copyright © 2017 wales. All rights reserved.
    //
    
    import UIKit
    
    class LiveFeedTicketCollectionViewCell: UICollectionViewCell {
        
        @IBOutlet weak var mainView: UIView!
        @IBOutlet weak var imgObj: UIImageView!
        
        @IBOutlet weak var priceObj: UILabel!
        @IBOutlet weak var titleCell: UILabel!
        
        @IBOutlet weak var constructorName: UILabel!
        
        @IBOutlet weak var sizeObj: UILabel!
        @IBOutlet weak var qteObj: UILabel!
        @IBOutlet weak var s5: UIImageView!
        @IBOutlet weak var s4: UIImageView!
        @IBOutlet weak var s3: UIImageView!
        @IBOutlet weak var s2: UIImageView!
        @IBOutlet weak var s1: UIImageView!
        @IBOutlet weak var viewImgObj: UIView!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            
            viewImgObj.layer.cornerRadius = 5
            viewImgObj.layer.masksToBounds = true
            mainView.layer.cornerRadius = 5
            mainView.layer.masksToBounds = true
            
            imgObj.layer.cornerRadius = 5
            imgObj.layer.masksToBounds = true
        }
        
 }
