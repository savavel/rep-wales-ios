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
class CustomTextField: UITextField {
    
    @IBInspectable var cornerRaduis : CGFloat = 0
    @IBInspectable var  fillColor : UIColor = UIColor.blue
    @IBInspectable var  borderColor : UIColor = UIColor.blue
    @IBInspectable var placeHolder : String = ""
    
    
    
    override func draw(_ rect: CGRect) {
        
        self.layer.cornerRadius = cornerRaduis
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor.cgColor
        self.layer.backgroundColor = fillColor.cgColor
        self.attributedPlaceholder = NSAttributedString(string: placeHolder,  attributes: [NSForegroundColorAttributeName : UIColor.gray])
        
        
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10) )
        
        self.leftView = paddingView
        self.leftViewMode = .always
        
        
    }
    
    
    
}
