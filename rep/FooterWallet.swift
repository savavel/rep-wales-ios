//
//  FooterWallet.swift
//  rep
//
//  Created by MacBook Pro on 21/10/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit

class FooterWallet: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        img.clipsToBounds = true
        
        viewImage.clipsToBounds = false
        viewImage.layer.shadowColor = UIColor.black.cgColor
        viewImage.layer.shadowOpacity = 0.6
        viewImage.layer.shadowOffset = CGSize.zero
        viewImage.layer.shadowRadius = 7
        viewImage.layer.shadowPath = UIBezierPath(roundedRect: viewImage.bounds, cornerRadius: 10).cgPath
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundCorners([.bottomLeft, .bottomRight], radius: 10)
    }

}
