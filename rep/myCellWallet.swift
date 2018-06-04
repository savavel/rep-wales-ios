//
//  myCellWallet.swift
//  rep
//
//  Created by MacBook Pro on 17/10/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import MapKit

class myCellWallet: UITableViewCell , UITableViewDelegate , UITableViewDataSource{
    var indexSection : Int? = 0
    @IBOutlet weak var tableView: UITableView!
    var feeds : [Feed] = []
    var client : Client? = nil
    var listWalletViewController : ListWalletViewController? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InsideWalletCell") as! InsideWalletCell
        //cell.quantity.text = feeds[indexPath.row].nameShort
        
        cell.title.heroID = "wallet\(feeds[indexPath.row].name)\(feeds[indexPath.row].modifiers)"
        cell.img.heroID = "wallet\(feeds[indexPath.row].iconUrl)\(feeds[indexPath.row].modifiers)"
        
        
        print("kkkkkkk")
        print("wallet\(feeds[indexPath.row].iconUrl)\(feeds[indexPath.row].modifiers)")
        
        
        cell.title.text = feeds[indexPath.row].name
        if let url = URL.init(string: feeds[indexPath.row].iconUrl) {
            //cell.downloadedFrom(url: url)
            cell.img.downloadedFrom(url: url)
            cell.img.contentMode = .scaleToFill
            cell.img.layer.cornerRadius = 10
            cell.img.layer.masksToBounds = true
            cell.img.clipsToBounds = true
            
            
            
            cell.viewImage.contentMode = .scaleToFill
            cell.viewImage.layer.cornerRadius = 10
            cell.viewImage.layer.masksToBounds = false
          

        }
        cell.quantity.text = "\(feeds[indexPath.row].balance)X"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(" \(indexSection) \(indexPath.row)")
        listWalletViewController?.performSegue(withIdentifier: "segueDetailsClientProduct", sender:  feeds[indexPath.row])
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  header : HeaderWallet = Bundle.main.loadNibNamed("HeaderWallet", owner: self, options: nil)?[0] as! HeaderWallet
        header.layer.cornerRadius = 10
        header.layer.masksToBounds = true
        header.title.text = "#\(indexSection!+1) \(client!.name)"
        
        // CALC Distance TODO
        let currentLocation = CLLocationCoordinate2DMake(AppDelegate.currentLocaitonLatitude, AppDelegate.currentLocaitonLongitude)
        /********* Distance ************/
        
        
        let lat0 : Double =  Double.init("\(currentLocation.latitude)")!
        
        let lon0 : Double =  Double.init("\(currentLocation.longitude)")!
        
        let lat1 : Double =  Double.init("\(client!.latitude)")!
        
        let lon1 : Double =  Double.init("\(client!.longitude)")!
        
        let coordinate0 = CLLocation(latitude: lat0, longitude: lon0)
        
        let coordinate1 = CLLocation(latitude: lat1, longitude: lon1)
        
        let distanceInMeters = "\(coordinate1.distance(from: coordinate0))"
        
        if let range = distanceInMeters.range(of: ".") {
            let firstPart = distanceInMeters[distanceInMeters.startIndex..<range.lowerBound]
            print(firstPart) // print Hello
         header.distance.text = "\(firstPart)mi"
        }
        
        return header
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
 
    
}
