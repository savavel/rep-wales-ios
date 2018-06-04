//
//  BottomCollectionViewCell.swift
//  rep
//
//  Created by bechir Kaddech on 8/31/17.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit

class BottomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var isOpen: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var orderBTN: UIButton!
    @IBOutlet weak var title: UILabel!    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var bottomContainer : UIView!
    var ObjFeedMap : StarbucksAnnotation? = nil
    var client : Client? = nil


    var viewC : MapViewController? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.clipsToBounds = false
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize.zero
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowPath = UIBezierPath(roundedRect: imageView.bounds, cornerRadius: 10).cgPath
        
        
        orderBTN.layer.cornerRadius = 10
        orderBTN.layer.shadowColor = UIColor.blue.cgColor
        orderBTN.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        orderBTN.layer.shadowRadius = 3
        orderBTN.layer.shadowOpacity = 0.3
        
        bottomContainer.layer.cornerRadius = 10
        bottomContainer.clipsToBounds = true 
        
        
        /**************************/
    
        
     }
    
   
    @IBAction func action(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "FeedClient", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsLiveFeed2") as! DetailsLiveFeed2ViewController
        let c : Client = Client()
        c.address = self.ObjFeedMap!.address
        c.facebook = "self.ObjFeedMap!"
        c.image = self.ObjFeedMap!.image
        c.instagram = "self.ObjFeedMap!.ins"
        c.lastname = self.ObjFeedMap!.lastname
        c.latitude = self.ObjFeedMap!.latitude
        c.longitude = self.ObjFeedMap!.longitude
        c.mnemonic = "self.ObjFeedMap!."
        c.name = self.ObjFeedMap!.name
        c.phone = self.ObjFeedMap!.phone
        c.physical_address = self.ObjFeedMap!.physical_address
        c.times = self.ObjFeedMap!.times
        c.twitter = ""
        c.website = self.ObjFeedMap!.website
        self.client = c
        newViewController.client = c
        
        viewC?.present(newViewController, animated: true, completion: nil)
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
}
