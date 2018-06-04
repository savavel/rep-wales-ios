//
//  CustomTextField.swift
//  rep
//
//  Created by bechir Kaddech on 8/30/17.
//  Copyright © 2017 wales. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var cornerRaduis : CGFloat = 0
    @IBInspectable var  fillColor : UIColor = UIColor.blue
    @IBInspectable var  borderColor : UIColor = UIColor.blue
    @IBInspectable var placeHolder : String = ""
    
    
    
    override func draw(_ rect: CGRect) {
        
        self.layer.cornerRadius = cornerRaduis
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor.cgColor
        self.layer.backgroundColor = fillColor.cgColor
        
        
        
       
        
        
    }
    
    
    
}
