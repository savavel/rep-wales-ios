//
//  popUpCardMapViewController.swift
//  rep
//
//  Created by MacBook Pro on 04/10/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import MapKit

class popUpCardMapViewController: UIViewController {

    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var partDay2lbl: UILabel!
    @IBOutlet weak var partDay1lbl: UILabel!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnOrder: UIButton!

    @IBOutlet weak var isOpen: UILabel!
    @IBOutlet weak var viewG: UIView!

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var viewBackground: UIView!
    var starbucksAnnotation : StarbucksAnnotation? = nil
    let currentLocation = CLLocationCoordinate2DMake(AppDelegate.currentLocaitonLatitude, AppDelegate.currentLocaitonLongitude)

    override func viewDidLoad() {
        super.viewDidLoad()
        print("***************** Image \(starbucksAnnotation?.image)")
        print("***************** website \(starbucksAnnotation?.website)")
        print("***************** address \(starbucksAnnotation?.address)")

        print("***************** Time \(starbucksAnnotation?.times)")
       
        viewG.layer.cornerRadius = 5
        view1.layer.cornerRadius = view1.frame.width/2

        
        btnOrder.layer.cornerRadius = 5
        btnCall.layer.cornerRadius = 5
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedClose(tapGestureRecognizer:)))
        viewBackground.isUserInteractionEnabled = true
        viewBackground.addGestureRecognizer(tapGestureRecognizer)
        img.layer.cornerRadius = img.frame.width/2
        if let url = URL.init(string: (starbucksAnnotation?.image)!) {
            img.downloadedFrom(url: url)
            img.contentMode = .scaleAspectFill
        }
        
        /**********************/
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale =  Locale(identifier: "en_US")
        
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "ha"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let dateStringWithAMPM = formatter.string(from: Date())
        
        let formatterString = DateFormatter()
        formatterString.calendar = Calendar(identifier: .iso8601)
        formatterString.locale =  Locale(identifier: "en_US")
        
        formatterString.timeZone = TimeZone(secondsFromGMT: 0)
        formatterString.dateFormat = "h"
        formatterString.amSymbol = "AM"
        formatterString.pmSymbol = "PM"
        let dateString = formatterString.string(from: Date())
        
        
        print(dateStringWithAMPM)
        print(dateString)
        
        let currentH : Int = Int(dateString)!
        let currentHoure = dateStringWithAMPM.uppercased()
        
        let dates = (starbucksAnnotation?.times)!.uppercased().components(separatedBy: " - ")
        let timeStart1 : String = dates[0]
        let timess  = dates[1].components(separatedBy: " ")
        let timeClose1 : String = timess[0]
        let timeStart2 : String = timess[1]
        let timeClose2 : String = dates[2]
        let nbHeureStart1 : Int = Int(timeStart1.components(separatedBy: "AM")[0] )!
        print(timeClose1.components(separatedBy: "AM")[0])
        let nbHeureClose1 : Int = Int(timeClose1.components(separatedBy: "PM")[0] )!
        let nbHeureStart2 : Int = Int(timeStart2.components(separatedBy: "PM")[0] )!
        let nbHeureClose2 : Int = Int(timeClose2.components(separatedBy: "PM")[0] )!
        print("currentHoure == \(currentHoure)")
        if (currentHoure.contains("AM")){
            if (((nbHeureStart1 <= currentH) )  ){
                isOpen.text = "OPEN NOW"
            }else {
                isOpen.text = "CLOSE NOW"
            }
        }else {
            if (((nbHeureStart2 <= currentH) && (currentH < nbHeureClose2 )) || (currentH < nbHeureClose1 )  ){
                isOpen.text = "OPEN NOW"
                
            }else {
                 isOpen.text = "CLOSE NOW"
            }
        }
       
        partDay1lbl.text = "\(timeStart1) - \(timeClose1)"
        partDay2lbl.text = "\(timeStart2) - \(timeClose2)"
        
        /********* Distance ************/
        
        
        let lat0 : Double =  Double.init("\(currentLocation.latitude)")!
        
        let lon0 : Double =  Double.init("\(currentLocation.longitude)")!
        
        let lat1 : Double =  Double.init("\(starbucksAnnotation!.latitude)")!
        
        let lon1 : Double =  Double.init("\(starbucksAnnotation!.longitude)")!
        
        let coordinate0 = CLLocation(latitude: lat0, longitude: lon0)
        
        let coordinate1 = CLLocation(latitude: lat1, longitude: lon1)
        
        let distanceMilles = ( (coordinate1.distance(from: coordinate0)) / 1609.344 )
        
        let distanceInMeters = "\(distanceMilles)"
        if let range = distanceInMeters.range(of: ".") {
            
            let firstPart = distanceInMeters[distanceInMeters.startIndex..<range.lowerBound]
            
            print(firstPart) // print Hello
            
             self.distance.text = "\(firstPart)mi"
            
        }
        
        /*******************************/
        
        print("\(nbHeureStart1) \(nbHeureClose1) \(nbHeureStart2) \(nbHeureClose2)")
        /**********************/
        
        txtName.text = starbucksAnnotation!.name
       
        self.showAnimate()
    }
    func tappedClose(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.removeAnimate()
    }
   
    /********** Animation ************/
    
    
    func showAnimate()
    {
       self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
        
    }
    @IBAction func callAction(_ sender: Any) {
        print("******************   \("telprompt://\(starbucksAnnotation!.phone)") ")
        if let url = URL(string: "telprompt://\((starbucksAnnotation!.phone))"), UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func openAction(_ sender: Any) {
        print("**************  GoToVenusClientAction ")
        let storyBoard: UIStoryboard = UIStoryboard(name: "FeedClient", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsLiveFeed2") as! DetailsLiveFeed2ViewController
        let v = starbucksAnnotation!
        let c : Client = Client()
        c.address = v.address
        c.facebook = "self.ObjFeedMap!"
        c.image =  v.image
        c.instagram = "self.ObjFeedMap!.ins"
        c.lastname =  v.lastname
        c.latitude =  v.latitude
        c.longitude =  v.longitude
        c.mnemonic = "self.ObjFeedMap!."
        c.name =  v.name
        c.phone =  v.phone
        c.physical_address =  v.physical_address
        c.times =  v.times
        c.twitter = ""
        c.website =  v.website
        newViewController.client = c
        self.present(newViewController, animated: true, completion: nil)
    }
    /********** End Animation ************/

}
