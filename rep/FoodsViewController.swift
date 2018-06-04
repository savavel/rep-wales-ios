 

 
    //
    //  drinksViewController.swift
    //  rep
    //
    //  Created by MacBook Pro on 01/09/2017.
    //  Copyright © 2017 wales. All rights reserved.
    //
    
    import UIKit
    import KeychainSwift
    import MapKit
 import NVActivityIndicatorView

    class FoodsViewController: SUPERCLASSViewController  , UICollectionViewDataSource, UICollectionViewDelegate , NVActivityIndicatorViewable{
        let keychain = KeychainSwift()
        
        @IBOutlet weak var loadingView: NVActivityIndicatorView!
        
        
        @IBOutlet weak var tableView: UICollectionView!
        let placeholderImage : UIImage? = nil
        
        private var gradient: CAGradientLayer!

        var tabFeed : [Feed] =  []
        var tabFeedNonSorted : [Feed] =  []
        var refreshControl:UIRefreshControl!


        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            loadingView.isHidden = true
            
            //Pull to Refresh control
            self.tableView.alwaysBounceVertical = true
            self.refreshControl = UIRefreshControl()
            self.refreshControl.attributedTitle = NSAttributedString(string: "")
            self.refreshControl.tintColor = UIColor.white
            self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
            tableView!.addSubview(refreshControl)
            

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
            
            let token : String = self.keychain.get("token") as! String
            //  self.keychain.set(JSONResponse["token"].string!, forKey: "token")
            
            
            
            for i in clients {
                getDataByCategory(category: "food", wallet: i.address, token: token , client : i , compteur : -1)
            }
          
        
        
        }
        
        func refresh(sender:AnyObject)
        {
            let token : String = self.keychain.get("token") as! String
            //  self.keychain.set(JSONResponse["token"].string!, forKey: "token")
            
           
            var compteur : Int = 0
            for i in clients {
                print("WALLET , +  \(i.address) ")
                getDataByCategory(category: "food", wallet: i.address, token: token , client : i , compteur : compteur)
                compteur = compteur + 1
            }
            
        }
        
        
        override func viewDidLayoutSubviews() {
            gradient.frame = view.bounds
            
        }
        
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
            return tabFeed.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = tableView.dequeueReusableCell(withReuseIdentifier: "LiveFeedFoodCollectionViewCell", for: indexPath) as! LiveFeedFoodCollectionViewCell
            
            cell.layer.cornerRadius = 9
            cell.clipsToBounds = true
            let tabFeedSorted = tabFeed.sorted { $0.rating > $1.rating }[indexPath.row]

            
            
            cell.titleCell.text = tabFeedSorted.name
            //cell.qteObj.text = tabFeed[indexPath.row].nameShort
            if (tabFeed[indexPath.row].rating == "0"){
                cell.s1.image =  UIImage(named: "start_empty")
                cell.s2.image =  UIImage(named: "start_empty")
                cell.s3.image =  UIImage(named: "start_empty")
                cell.s4.image =  UIImage(named: "start_empty")
                cell.s5.image =  UIImage(named: "start_empty")
            }
            else if (tabFeed[indexPath.row].rating == "1"){
                cell.s1.image =  UIImage(named: "start_full")
                cell.s2.image =  UIImage(named: "start_empty")
                cell.s3.image =  UIImage(named: "start_empty")
                cell.s4.image =  UIImage(named: "start_empty")
                cell.s5.image =  UIImage(named: "start_empty")
            } else if (tabFeed[indexPath.row].rating == "1.5"){
                cell.s1.image =  UIImage(named: "start_full")
                cell.s2.image =  UIImage(named: "start_half_full")
                cell.s3.image =  UIImage(named: "start_empty")
                cell.s4.image =  UIImage(named: "start_empty")
                cell.s5.image =  UIImage(named: "start_empty")
            } else if (tabFeed[indexPath.row].rating == "2"){
                cell.s1.image =  UIImage(named: "start_full")
                cell.s2.image =  UIImage(named: "start_full")
                cell.s3.image =  UIImage(named: "start_empty")
                cell.s4.image =  UIImage(named: "start_empty")
                cell.s5.image =  UIImage(named: "start_empty")
            } else if (tabFeed[indexPath.row].rating == "2.5"){
                cell.s1.image =  UIImage(named: "start_full")
                cell.s2.image =  UIImage(named: "start_full")
                cell.s3.image =  UIImage(named: "start_half_full")
                cell.s4.image =  UIImage(named: "start_empty")
                cell.s5.image =  UIImage(named: "start_empty")
            }else if (tabFeed[indexPath.row].rating == "3"){
                cell.s1.image =  UIImage(named: "start_full")
                cell.s2.image =  UIImage(named: "start_full")
                cell.s3.image =  UIImage(named: "start_full")
                cell.s4.image =  UIImage(named: "start_empty")
                cell.s5.image =  UIImage(named: "start_empty")
            } else if (tabFeed[indexPath.row].rating == "3.5"){
                cell.s1.image =  UIImage(named: "start_full")
                cell.s2.image =  UIImage(named: "start_full")
                cell.s3.image =  UIImage(named: "start_full")
                cell.s4.image =  UIImage(named: "start_half_full")
                cell.s5.image =  UIImage(named: "start_empty")
            }else if (tabFeed[indexPath.row].rating == "4"){
                cell.s1.image =  UIImage(named: "start_full")
                cell.s2.image =  UIImage(named: "start_full")
                cell.s3.image =  UIImage(named: "start_full")
                cell.s4.image =  UIImage(named: "start_full")
                cell.s5.image =  UIImage(named: "start_empty")
            } else if (tabFeed[indexPath.row].rating == "4.5"){
                cell.s1.image =  UIImage(named: "start_full")
                cell.s2.image =  UIImage(named: "start_full")
                cell.s3.image =  UIImage(named: "start_full")
                cell.s4.image =  UIImage(named: "start_full")
                cell.s5.image =  UIImage(named: "start_half_full")
            }else if (tabFeed[indexPath.row].rating == "5"){
                cell.s1.image =  UIImage(named: "start_full")
                cell.s2.image =  UIImage(named: "start_full")
                cell.s3.image =  UIImage(named: "start_full")
                cell.s4.image =  UIImage(named: "start_full")
                cell.s5.image =  UIImage(named: "start_full")
            }
            /**************************************************/
            let currentLocation = CLLocationCoordinate2DMake(AppDelegate.currentLocaitonLatitude, AppDelegate.currentLocaitonLongitude)
            /********* Distance ************/
            
            
            let lat0 : Double =  Double.init("\(currentLocation.latitude)")!
            
            let lon0 : Double =  Double.init("\(currentLocation.longitude)")!
            
            let lat1 : Double =  Double.init("\(tabFeedSorted.client.latitude)")!
            
            let lon1 : Double =  Double.init("\(tabFeedSorted.client.longitude)")!
            
            let coordinate0 = CLLocation(latitude: lat0, longitude: lon0)
            
            let coordinate1 = CLLocation(latitude: lat1, longitude: lon1)
            
            let distanceMilles = ( (coordinate1.distance(from: coordinate0)) / 1609.344 )
            
            let distanceInMeters = "\(distanceMilles)"
            if let range = distanceInMeters.range(of: ".") {
                let firstPart = distanceInMeters[distanceInMeters.startIndex..<range.lowerBound]
                print(firstPart) // print Hello
                  cell.sizeObj.text = "\(firstPart)mi"
            }
            
            
            /*****************************************************/
            cell.priceObj.text = "$\(tabFeedSorted.price)"
            cell.constructorName.text = "@\(tabFeedSorted.client.name) \(tabFeedSorted.client.lastname)"
            ///asset/p2pkh/XyXC3CgnJpPsWkNSK3AGNy92zk8uvd1e2T/
            
            //Hero animation for transations
            cell.imgObj!.heroID = tabFeedSorted.iconUrl
            print("herrrrrrrrrrrrrrrro")
            print(tabFeedSorted.iconUrl)
            cell.titleCell.heroID = tabFeedSorted.name
            cell.priceObj.heroID =  "price\(tabFeedSorted.name)"
            
            if let url = URL.init(string: tabFeedSorted.iconUrl) {
                cell.imgObj.af_setImage(withURL: url,placeholderImage: placeholderImage,imageTransition: .crossDissolve(0.5))

                cell.imgObj.contentMode = .scaleToFill

            }
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
            
            performSegue(withIdentifier:"Detail", sender: nil)
            
            
        }
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "Detail" {
                
                let controller = segue.destination as? PizzaDetailViewController
                let indexPaths : NSArray = self.tableView!.indexPathsForSelectedItems as! NSArray
                let indexPath : NSIndexPath = indexPaths[0] as! NSIndexPath
                controller?.feedPassed = tabFeed[(indexPath.row)]
                let cell = tableView.cellForItem(at: indexPath as IndexPath) as? LiveFeedFoodCollectionViewCell
                
                controller?.productImage = cell?.imgObj.image
                
            }
        }
        
        func getDataByCategory(category : String , wallet : String , token : String , client : Client, compteur : Int){
            
            if self.refreshControl.isRefreshing == false  {
                self.loadingView.isHidden = false
                self.loadingView.startAnimating()
            }
            
            
            let params  =   ["wallet":"\(wallet)",
                "category":"\(category)"]
            let headers = ["Authorization":"Bearer \(token)"]
            loadingView.isHidden = false
       
            //self.tabFeed = []
            //self.tableView.reloadData()
            print("params , \(params)")
            print("headers , \(headers)")
            print("Urls.CATAGORY_LIST = \(Urls.CATAGORY_LIST)")
            self.tabFeedNonSorted.removeAll()
            
            AFWrapper.requestPOSTURL(Urls.CATAGORY_LIST, params: params, headers: headers,
                                     success: {
                                        (JSONResponse) -> Void in
                                        
                                        print(JSONResponse)
                                        for i in JSONResponse.array! {
                                            
                                            let feed : Feed = Feed()
                                            feed.account = i["account"].string!
                                            feed.asset = i["asset"].string!
                                            feed.balance = i["balance"].string!
                                            feed.category = i["category"].string!
                                            feed.iconUrl = i["iconUrl"].string!
                                            feed.name = i["name"].string!
                                            feed.nameShort = i["nameShort"].string!
                                            feed.path = i["path"].string!
                                            feed.price =  i["price"].string!
                                            feed.info = i["description"].string!

                                            feed.client = client
                                            if ( i["rating"] == nil ) {
                                                feed.rating = "0"
                                            }else {
                                                feed.rating =  i["rating"].string!
                                            }
                                            if ( i["subcategory"] == nil ) {
                                                feed.subcategory = ""
                                            }else {
                                                feed.subcategory =  i["subcategory"].string!
                                            }
                                            feed.version =  i["version"].string!
                                            
                                            feed.modifiers = i["modifiers"]
                                            
                                            
                                            if (i["bulk"] == nil) {
                                                
                                                
                                            }else {
                                                feed.isBulk = true
                                                feed.bulk = i["bulk"].floatValue
                                                
                                            }

                                            
                                            
                                            self.tabFeedNonSorted.append(feed)
                                            
                                            
                                        }
                                        self.tabFeed.removeAll()
                                        self.tabFeed = self.tabFeedNonSorted.sorted(by: { $0.rating > $1.rating })

 
                                        self.loadingView.stopAnimating()
                                        self.loadingView.isHidden = true
                                        
                                        self.refreshControl.endRefreshing()
                                        self.tableView.reloadData()
 
                                        
                                        
            }) {
                (error) -> Void in
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }else {
                    
                    self.loadingView.stopAnimating()
                    self.loadingView.isHidden = true
                }
                
                
                print(error)
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
