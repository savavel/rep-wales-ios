//
//  HeaderWallet.swift
//  rep
//
//  Created by MacBook Pro on 16/10/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit

class HeaderWallet: UIView {

    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var viewHeader: UIView!
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.viewHeader.roundCorners([.topLeft, .topRight], radius: 10)
    }
}
