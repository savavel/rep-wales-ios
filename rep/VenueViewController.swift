//
//  VenueViewController.swift
//  rep
//
//  Created by bechir kaddech on 9/20/17.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import MapKit

class VenueViewController: ObjectFeedClientViewController {

    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    
    
    
    @IBOutlet weak var mnemonic: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        picture.layer.cornerRadius = 20
        picture.clipsToBounds = true
        
    
        
        print("venuee facebook")
        
        print (client?.facebook as! String)
        
        name.text = "\(client?.name as! String) \(client?.lastname as! String)"
        adress.text = client?.physical_address as! String
        time.text = client?.times as! String
        phone.text = client?.phone as! String
        email.text = client?.website as! String
        mnemonic.text = client?.info as! String

        if let url = URL.init(string: client!.image) {
            picture.downloadedFrom(url: url)
            
        }
        
        



    }

  
    @IBAction func getDirectionAction(_ sender: Any) {
        let coordinate = CLLocationCoordinate2DMake(Double(client?.latitude as! String)!,Double(client?.longitude as! String)!)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = "\(client?.name as! String) \(client?.lastname as! String)"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    @IBOutlet weak var twitterPress: UIButton!
    @IBOutlet weak var facebookAction: UIButton!
    @IBAction func FacebookPress(_ sender: Any) {
        if let url = NSURL(string: (client?.facebook)!){
            UIApplication.shared.openURL(url as URL)
        }
    }
    @IBAction func instagramPress(_ sender: Any) {
    }
}
