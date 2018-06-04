//
//  ListHistoryWalletViewController.swift
//  rep
//
//  Created by MacBook Pro on 27/10/2017.
//  Copyright © 2017 wales. All rights reserved.
//



    import UIKit
    import KeychainSwift
    import NVActivityIndicatorView
    import MapKit
    class ListHistoryWalletViewController: UIViewController  , UITableViewDelegate, UITableViewDataSource , NVActivityIndicatorViewable , UIGestureRecognizerDelegate {
        let keychain = KeychainSwift()
        
        @IBOutlet weak var tableViewItems: UITableView!
        @IBOutlet weak var loadingView: NVActivityIndicatorView!
        @IBOutlet weak var tableView: UITableView!
        var tabFeed : [Feed] =  []
        var tab : [Wallet_users] = []
        private var gradient: CAGradientLayer!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.delegate = self
            tableView.dataSource = self
            self.tableView.isScrollEnabled = true
            
            
            
            
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
        }
        override func viewWillAppear(_ animated: Bool) {
            
            let token : String = self.keychain.get("token")!
            let wallet : String = self.keychain.get("wallet")!
            loadingView.isHidden = false
            getDATAWallet(  wallet: wallet, token: token)
            
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
        
        
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return tab.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return (tab[section].feeds.count - 1 )
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InsideWalletCell" , for: indexPath) as! InsideWalletCell
            
            /* cell.feeds = tab[indexPath.section].feeds
             cell.client = tab[indexPath.section].client
             
             cell.layer.cornerRadius = 9
             cell.clipsToBounds = true
             cell.listWalletViewController = self
             cell.indexSection = indexPath.section*/
            
            cell.title.heroID = "wallet\(tab[indexPath.section].feeds[indexPath.row].name)\(tab[indexPath.section].feeds[indexPath.row].modifiers)"
            cell.img.heroID = "wallet\(tab[indexPath.section].feeds[indexPath.row].iconUrl)\(tab[indexPath.section].feeds[indexPath.row].modifiers)"
            
            /*    if (tableView.isLast(for: indexPath)){
             }*/
            
            
            
            cell.title.text = tab[indexPath.section].feeds[indexPath.row].name
            if let url = URL.init(string: tab[indexPath.section].feeds[indexPath.row].iconUrl) {
                //cell.downloadedFrom(url: url)
                cell.img.af_setImage(withURL: url,imageTransition: .crossDissolve(0.5))
                cell.img.contentMode = .scaleToFill
                cell.img.layer.cornerRadius = 10
                cell.img.layer.masksToBounds = true
                cell.img.clipsToBounds = true
                
                
                
                cell.viewImage.contentMode = .scaleToFill
                cell.viewImage.layer.cornerRadius = 10
                cell.viewImage.layer.masksToBounds = false
                
                
            }
            cell.quantity.text = "\(tab[indexPath.section].feeds[indexPath.row].balance)X"
            /******** Modifiers *********/
            var strTxt : String = ""
            for data in tab[indexPath.section].feeds[indexPath.row].modifiers.array! {
                
                for (key, value) in data {
                    
                    //MinMaxList.append(value)
                    strTxt = "\(strTxt) - \(key)"
                    
                    
                    for (key2,value2) in value{
                        
                        
                        
                        if key2 == "min_modifiers" || key2 == "max_modifiers" {
                            
                        }
                        else {
                            print("*************** Modifiers : \(key2)")
                            
                            strTxt = "\(strTxt) - \(key2)"
                            //optionsList.append(key2)
                            // TMPPickerNumberList.append(value2.string!)
                            
                        }
                        
                    }
                    //PickerNameList.append(TMPPickerNameList)
                    //PickerNumberList.append(TMPPickerNumberList)
                    
                }
                
                //self.tableViez.reloadData()
                
            }
            strTxt =  strTxt.trimmingCharacters(in: .whitespacesAndNewlines)
            if (strTxt.characters.count != 0){
                strTxt.removeFirst()
            }
            cell.modifiers.text = strTxt
            
            
            return cell
            
        }
        
        
        func getDATAWallet( wallet : String , token : String){
            
            
            print("bechir over here")
            print(token)
            print(wallet)
            let params  =   ["wallet":"\(wallet)"]
            loadingView.isHidden = false
            loadingView.startAnimating()
            self.tab = []
            self.tableView.reloadData()
            print("params , \(params)")
             print("WALLET = \(Urls.WALLET)")
            print("************************************* START WALLET HISTORY ")
            AFWrapper.requestPOSTURL(Urls.WALLET_HISTORY, params: params, headers: [:],
                                     success: {
                                        (JSONResponse) -> Void in
                                        
                                        
                                        for i in JSONResponse.array! {
                                            
                                            let wallet_user : Wallet_users = Wallet_users()
                                            
                                            let k = i.dictionaryValue
                                            
                                            print("**************** KEY")
                                            print(k.keys.first!)
                                            for c in AppDelegate.clients {
                                                if (c.address == k.keys.first!){
                                                    print("yesss")
                                                    wallet_user.client = c
                                                }
                                            }
                                            
                                            print("**************** VALUE")
                                            print(k.values.first?.array?.count)
                                            for i in (k.values.first?.array!)!{
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
                                                feed.info =  i["description"].string!
                                                
                                                if ( i["rating"] == nil ) {
                                                    feed.rating = "0"
                                                }else {
                                                    feed.rating =  i["rating"].string!
                                                }
                                                if ( i["category"] == nil ) {
                                                    feed.subcategory =  ""
                                                }else {
                                                    feed.subcategory =  i["category"].string!
                                                }
                                                feed.version =  i["version"].string!
                                                
                                                feed.modifiers = i["modifiers"]
                                                feed.client = wallet_user.client!
                                                wallet_user.feeds.append(feed)
                                            }
                                            self.tab.append(wallet_user)
                                        }
                                        
                                        print("DONE")
                                        print("Users_wallet = \(self.tab.count)")
                                        for  d in self.tab{
                                            print(d.feeds.count)
                                        }
                                        self.tableView.reloadData()
                                        self.loadingView.isHidden = true
                                        self.loadingView.stopAnimating()
                                        
                                        
            }) {
                (error) -> Void in
                self.loadingView.isHidden = true
                self.loadingView.stopAnimating()
                print(error)
            }
            print("************************************* END WALLET ")
            
        }
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "segueDetailsClientProduct") {
                let s : DetailsWalletViewController = segue.destination as!  DetailsWalletViewController
                
                s.feed = sender as! Feed
                
                
            }
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //self.performSegue(withIdentifier: "segueDetailsClientProduct", sender:  tab[indexPath.section].feeds[indexPath.row])
        }
        
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            //FooterWallet
            let  footer : FooterWallet = Bundle.main.loadNibNamed("FooterWallet", owner: self, options: nil)?[0] as! FooterWallet
            footer.roundCorners([.bottomLeft, .bottomRight], radius: 10)
            
            let item : Feed = tab[section].feeds[tab[section].feeds.count - 1]
            footer.title.heroID = "wallet\(item.name)\((tab[section].feeds.count)-1)"
            footer.img.heroID = "wallet\(item.iconUrl)\((tab[section].feeds.count)-1)"
            
            /*    if (tableView.isLast(for: indexPath)){
             }*/
            
            
            
            footer.title.text = item.name
            
            if let url = URL.init(string: item.iconUrl) {
                //cell.downloadedFrom(url: url)
                footer.img.downloadedFrom(url: url)
                footer.img.contentMode = .scaleToFill
                footer.img.layer.cornerRadius = 10
                footer.img.layer.masksToBounds = true
                footer.img.clipsToBounds = true
                
                
                
                footer.viewImage.contentMode = .scaleToFill
                footer.viewImage.layer.cornerRadius = 10
                footer.viewImage.layer.masksToBounds = false
                
                
            }
            footer.quantity.text = "\(item.balance)X"
            
            // Add Action
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            tapRecognizer.delegate = self
            tapRecognizer.numberOfTapsRequired = 1
            tapRecognizer.numberOfTouchesRequired = 1
            footer.tag = section
            
            footer.addGestureRecognizer(tapRecognizer)
            
            return footer
        }
        func handleTap(gestureRecognizer: UIGestureRecognizer)
        {
            // self.performSegue(withIdentifier: "segueDetailsClientProduct", sender:  tab[indexPath.section].feeds[indexPath.row])
         /*   let v = gestureRecognizer.view!
            let tag = v.tag
            let item : Feed = tab[tag].feeds[tab[tag].feeds.count - 1]
            self.performSegue(withIdentifier: "segueDetailsClientProduct", sender:  item)*/
            print("Tapped")
        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let  header : HeaderWallet = Bundle.main.loadNibNamed("HeaderWallet", owner: self, options: nil)?[0] as! HeaderWallet
            
            header.layer.masksToBounds = true
            header.viewHeader.roundCorners([.topLeft, .topRight], radius: 10)
            header.title.text = "#\(section+1) \(tab[section].client!.name)  \(tab[section].client!.lastname)"
            
            // CALC Distance TODO
            let currentLocation = CLLocationCoordinate2DMake(AppDelegate.currentLocaitonLatitude, AppDelegate.currentLocaitonLongitude)
            /********* Distance ************/
            
            
            let lat0 : Double =  Double.init("\(currentLocation.latitude)")!
            
            let lon0 : Double =  Double.init("\(currentLocation.longitude)")!
            
            let lat1 : Double =  Double.init("\(tab[section].client!.latitude)")!
            
            let lon1 : Double =  Double.init("\(tab[section].client!.longitude)")!
            
            let coordinate0 = CLLocation(latitude: lat0, longitude: lon0)
            
            let coordinate1 = CLLocation(latitude: lat1, longitude: lon1)
            
            let distanceMilles = ( (coordinate1.distance(from: coordinate0)) / 1609.344 )
            
            let distanceInMeters = "\(distanceMilles)"
            if let range = distanceInMeters.range(of: ".") {
                let firstPart = distanceInMeters[distanceInMeters.startIndex..<range.lowerBound]
                print(firstPart) // print Hello
                header.distance.text = "\(firstPart)mi"
            }
            
            return header
            
        }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 59
        }
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 113
        }
        @IBAction func backAction(_ sender: Any) {
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        
}
