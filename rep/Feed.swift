//
//  Feed.swift
//  rep
//
//  Created by MacBook Pro on 01/09/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import  SwiftyJSON

class Feed : NSObject {
    
    var category : String = ""

    var price : String = ""
    var rating : String = ""
    
    
    var account : String = ""
    var asset : String = ""
    var balance : String  = ""
    var version : String = ""
    var name : String = ""
    var nameShort : String = ""
    var iconUrl : String = ""
    var path : String = ""
    var subcategory : String = ""
    var info : String = ""
    var bulk : Float = 0.0
    var isBulk : Bool = false

    var issuer : String = ""
    var modifiers : JSON = []
    
    var code : String = ""
    
    var client : Client = Client()

    
}
