//
//  MenuCell.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

     @IBOutlet weak var lblMenuname: UILabel!
    @IBOutlet weak var backgroundMenuCell: UIView!
     override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //set cell to initial state here, reset or set values, etc.
    }


}
