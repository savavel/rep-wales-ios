//
//  StarbucksAnnotation.swift
//  CustomCalloutView
//
//  Created by Malek T. on 3/16/16.
//  Copyright © 2016 Medigarage Studios LTD. All rights reserved.
//

import MapKit

class StarbucksAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
  
    
    
    
    var address : String = ""
    var categories :  [String] =  []
    var image : String = ""
    var lastname : String = ""
    var latitude : String = ""
    var longitude : String = ""
    var name : String = ""
    var phone : String = ""
    var physical_address : String  = ""
    var purchases : String = ""
    var times : String = ""
    var website : String = ""
    
    
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
