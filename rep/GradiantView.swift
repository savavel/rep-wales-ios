//
//  GradiantView.swift
//  rep
//
//  Created by bechir Kaddech on 8/30/17.
//  Copyright © 2017 wales. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class GradiantView: UIView {
    @IBInspectable var firstColor : UIColor = UIColor.clear{
        didSet{
            updateView()
        }
    }
    @IBInspectable var secondColor : UIColor = UIColor.clear{
        didSet{
            updateView()
        }
    }
    override class var layerClass : AnyClass {
        get{
            return CAGradientLayer.self
        }
    }

    
    
    
    func updateView(){
        
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor.cgColor,secondColor.cgColor]
        
    }
}
