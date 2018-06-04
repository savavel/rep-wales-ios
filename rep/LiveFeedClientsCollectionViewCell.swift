//
//  LiveFeedClientsCollectionViewCell.swift
//  rep
//
//  Created by MacBook Pro on 02/09/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit

class LiveFeedClientsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categorys: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgObj: UIImageView!
    
     @IBOutlet weak var titleCell: UILabel!
    
    @IBOutlet weak var txtType: UILabel!
    
    @IBOutlet weak var distanceTxt: UILabel!
    
    @IBOutlet weak var viewImg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
      //  viewImgObj.layer.cornerRadius = 5
      //  viewImgObj.layer.masksToBounds = true
        mainView.layer.cornerRadius = 5
        mainView.layer.masksToBounds = true
        
        imgObj.layer.cornerRadius = 10
        imgObj.layer.masksToBounds = true
        imgObj.clipsToBounds = false

        viewImg.clipsToBounds = false
        viewImg.layer.shadowColor = UIColor.black.cgColor
        viewImg.layer.shadowOpacity = 1
        viewImg.layer.shadowOffset = CGSize.zero
        viewImg.layer.shadowRadius = 10
        viewImg.layer.shadowPath = UIBezierPath(roundedRect: viewImg.bounds, cornerRadius: 10).cgPath
        
     
       // imgObj.layer.cornerRadius = imgObj.frame.height / 2
       // imgObj.clipsToBounds = true

    }

}
