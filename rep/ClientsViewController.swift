//
//  ClientsViewController.swift
//  rep
//
//  Created by MacBook Pro on 02/09/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import KeychainSwift
import MapKit

class ClientsViewController: SUPERCLASSViewController  , UICollectionViewDataSource, UICollectionViewDelegate {
    let keychain = KeychainSwift()
    
    @IBOutlet weak var tableView: UICollectionView!
    
    private var gradient: CAGradientLayer!
    let placeholderImage : UIImage? = nil
    var refreshControl:UIRefreshControl!


    
    var tabClients : [Client] =  []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        //Gradient edges
        /******** FADE *********/
        gradient = CAGradientLayer()
        gradient.frame = tableView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 0.05, 0.95 , 1]
        tableView.layer.mask = gradient
        /***********************/
        
        tableView.delegate = self
        tableView.dataSource = self
        
    tabClients = clients
        
        
        //Pull to Refresh control
        self.tableView.alwaysBounceVertical = true
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.tintColor = UIColor.white
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        tableView!.addSubview(refreshControl)
        
        
        /******** FADE *********/
        gradient = CAGradientLayer()
        gradient.frame = tableView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 0.05, 0.95 , 1]
        tableView.layer.mask = gradient
        /***********************/
        
    }
    
    
    func refresh(sender:AnyObject)
    {
        
      getAllClients()
        
        
    }
    
    
     func  getAllClients(){
        //CLIENTS_LIST
        print("************************** CLIENTS_LIST")
        self.tabClients = []
        
        print("Urls.CLIENTS_LIST = \(Urls.CLIENTS_LIST)")
        AFWrapper.requestGETURL(Urls.CLIENTS_LIST, success: { (JSON) in
            print("******************************* SUCCESS")
            
            self.tableView.reloadData()

            
            for i in JSON.array! {
                
                let client  : Client = Client()
                
                client.name = i["name"].string!
                client.address = i["address"].string!
                client.latitude = i["latitude"].string!
                client.longitude = i["longitude"].string!
                //client.mnemonic = i["mnemonic"].string!
                client.lastname = i["lastname"].string!
                
                client.facebook = i["facebook"].string!
                client.image = i["image"].string!
                client.instagram = i["instagram"].string!
                client.phone = i["phone"].string!
                client.info = i["description"].string!
                client.physical_address = i["physical_address"].string!
                
                client.times = i["times"].string!
                client.twitter = i["twitter"].string!
                client.website = i["website"].string!
                client.purchases = i["purchases"].string!
                client.categorys = i["categories"].string!

                
                
                
                self.tabClients.append(client)
           
                
            }
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
            
            /*
            self.tableView.fadeOut(duration: 0.7, delay: 0.1, completion: { (finished) in
                if (finished == true){
                    self.tableView.fadeIn(completion: {
                        (finished: Bool) -> Void in
                        
                    })
                }
            })
            */
            
        }) { (Error) in
            print("******************************* ERROR")
            print(Error)
            self.tableView.reloadData()

            self.refreshControl.endRefreshing()

            
        }
    }
    
    
  
    
    
    
    override func viewDidLayoutSubviews() {
        gradient.frame = view.bounds
        
    }
    
    
    
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return tabClients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = tableView.dequeueReusableCell(withReuseIdentifier: "LiveFeedClientsCollectionViewCell", for: indexPath) as! LiveFeedClientsCollectionViewCell
        cell.layer.cornerRadius = 9
        cell.clipsToBounds = true
        
        
        cell.titleCell.text = "\(tabClients[indexPath.row].name) \(tabClients[indexPath.row].lastname)"
        cell.titleCell.heroID = "\(tabClients[indexPath.row].name)"
        cell.categorys.text =  "\(tabClients[indexPath.row].categorys.replacingOccurrences(of: ",", with: " / "))"
        print("************** \(tabClients[indexPath.row].physical_address)")
       // cell.txtType.text = "\(tabClients[indexPath.row].)"
        ///asset/p2pkh/XyXC3CgnJpPsWkNSK3AGNy92zk8uvd1e2T/
        
        if let url = URL.init(string: tabClients[indexPath.row].image) {
            cell.imgObj.af_setImage(withURL: url,placeholderImage: placeholderImage,imageTransition: .crossDissolve(0.5))

            cell.imgObj.contentMode = .scaleAspectFill
            cell.imgObj.layer.cornerRadius = 10
            cell.imgObj.clipsToBounds = true
        }
      
        let currentLocation = CLLocationCoordinate2DMake(AppDelegate.currentLocaitonLatitude, AppDelegate.currentLocaitonLongitude)
        /********* Distance ************/
        
        
        let lat0 : Double =  Double.init("\(currentLocation.latitude)")!
        
        let lon0 : Double =  Double.init("\(currentLocation.longitude)")!
        
        let lat1 : Double =  Double.init("\(tabClients[indexPath.row].latitude)")!
        
        let lon1 : Double =  Double.init("\(tabClients[indexPath.row].longitude)")!
        
        let coordinate0 = CLLocation(latitude: lat0, longitude: lon0)
        
        let coordinate1 = CLLocation(latitude: lat1, longitude: lon1)
        
        let distanceMilles = ( (coordinate1.distance(from: coordinate0)) / 1609.344 )
        
        let distanceInMeters = "\(distanceMilles)"
        if let range = distanceInMeters.range(of: ".") {
            let firstPart = distanceInMeters[distanceInMeters.startIndex..<range.lowerBound]
            print(firstPart) // print Hello
            cell.distanceTxt.text = "\(firstPart)mi"
        }
        
        
        
        /*******************************/
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        performSegue(withIdentifier: "segueProductClient", sender: tabClients[indexPath.row])
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "segueProductClient"){
            let svc : DetailsLiveFeed2ViewController = segue.destination as! DetailsLiveFeed2ViewController
            svc.client = sender as! Client
        }
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /******** FADE *********/
        gradient = CAGradientLayer()
        gradient.frame = tableView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 0.05, 0.95 , 1]
        tableView.layer.mask = gradient
        /***********************/
    }
    
    
    
    
}
