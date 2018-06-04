//
//  ChartTableViewCell.swift
//  rep
//
//  Created by bechir kaddech on 9/10/17.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit

class ChartTableViewCell: UITableViewCell {

    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var bigContainer: UIView!
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var bottomViez: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var chart = Chart()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        

        
        bigContainer.layer.cornerRadius = 10
        bigContainer.clipsToBounds = true 
//        bigContainer.layer.shadowOpacity =  0.9
//        bigContainer.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        bigContainer.layer.shadowRadius = 6
//        bigContainer.layer.shadowColor = UIColor(hexString : "#1D7CE3").cgColor
        
        
        
        
        
        
//        let rectShape = CAShapeLayer()
//        rectShape.bounds = bottomViez.frame
//        rectShape.position = bottomViez.center
//        rectShape.path = UIBezierPath(roundedRect: bottomViez.bounds, byRoundingCorners: [ .bottomRight , .bottomLeft], cornerRadii: CGSize(width: 10, height: 10)).cgPath
//
//        //Here I'm masking the textView's layer with rectShape layer
//        bottomViez.layer.mask = rectShape
//
        
        
          
        
    }
    
    func setChart(with chart : Chart) {
        self.chart = chart
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

    extension ChartTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {

        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.chart.modifiers.count

        }

        
      
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ModifCell", for: indexPath) as! ModifiersTableViewCell
            
            print("this is a test for the modifier")
            
            
            
            for (key, value) in chart.modifiers[indexPath.row] {
                
                cell.modifiers.text =  key
       
                
            }
            
            
            return cell
        }
        



}

