
 
 
 //
 //  PromotionViewController.swift
 //  rep
 //
 //  Created by MacBook Pro on 01/09/2017.
 //  Copyright © 2017 wales. All rights reserved.
 //
 
 import UIKit
 import KeychainSwift
import NVActivityIndicatorView
import MapKit

 class ListWalletViewController: UIViewController  , UITableViewDelegate, UITableViewDataSource , NVActivityIndicatorViewable , UIGestureRecognizerDelegate {
    let keychain = KeychainSwift()
    
     @IBOutlet weak var loadingView: NVActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var tabFeed : [Feed] =  []
    var tab : [Wallet_users] = []
    private var gradient: CAGradientLayer!
    var refreshControl:UIRefreshControl!
    
    var tabFeedNonSorted : [Wallet_users] =  []


    @IBOutlet weak var viewNoData: UIView!
    @IBOutlet weak var lottieView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
        //self.tableView.isScrollEnabled = true
        
    
        
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
      
        
        
        // Lottie
      /*  let animationView = LOTAnimationView(name: "empty_list")
        animationView.frame = self.lottieView.bounds
        animationView.bounds = self.lottieView.bounds
        animationView.contentMode = .scaleAspectFill
        self.lottieView.addSubview(animationView)
        animationView.loopAnimation = true
        animationView.play()
        */
        
        // Add Action for Click in viewNoData
        let gesture = UITapGestureRecognizer(target: self, action: #selector (self.someAction (_:)))
        self.viewNoData.addGestureRecognizer(gesture)
        
        
        // lottieView
  
        self.lottieView.addGestureRecognizer(gesture)
        

        
        
    }
    // Action for Click in viewNoData
    func someAction(_ sender:UITapGestureRecognizer){
        let token : String = self.keychain.get("token")!
        let wallet : String = self.keychain.get("wallet")!
        loadingView.isHidden = false
        getDATAWallet(  wallet: wallet, token: token , isRefresh: true)
    }
    
    func refresh(sender:AnyObject)
    {
        let token : String = self.keychain.get("token")!
        let wallet : String = self.keychain.get("wallet")!
        loadingView.isHidden = false
        getDATAWallet(  wallet: wallet, token: token , isRefresh: true)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
       self.tableView.tableHeaderView?.frame.size = CGSize(width: self.tableView.frame.width, height: CGFloat(59))
      self.tableView.tableFooterView?.frame.size =  CGSize(width: self.tableView.frame.width, height: CGFloat(113))
        let token : String = self.keychain.get("token")!
        let wallet : String = self.keychain.get("wallet")!
        loadingView.isHidden = false
        viewNoData.isHidden = true
        getDATAWallet(  wallet: wallet, token: token,isRefresh: false)
        
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
   
   
    func getDATAWallet( wallet : String , token : String , isRefresh : Bool){
        
        viewNoData.isHidden = true

        print("bechir over here")
        print(token)
        print(wallet)
        let params  =   ["wallet":"\(wallet)"]
        let headers = ["Authorization":"Bearer \(token)"]
        if self.refreshControl.isRefreshing == false  {
            self.loadingView.isHidden = false
            self.loadingView.startAnimating()
        }
        self.tabFeedNonSorted = []
  
        print("params , \(params)")
        print("headers , \(headers)")
        print("WALLET = \(Urls.WALLET)")
        print("************************************* START WALLET ")
        
        AFWrapper.requestPOSTURL(Urls.WALLET, params: params, headers: headers,
                                 success: {
                                    (JSONResponse) -> Void in
                                    self.tab = []
                                    self.tableView.reloadData()

                                    
                                    for i in JSONResponse.array! {
                                    print(i)
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
                                            feed.code = i["code"].string!
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
                                        self.tabFeedNonSorted.append(wallet_user)
                                    }
                                    
                                    
                                    self.tab.removeAll()
                                    self.tab = self.tabFeedNonSorted
                                    
                                    print("DONE")
                                    print("Users_wallet = \(self.tab.count)")
                                    for  d in self.tab{
                                        print(d.feeds.count)
                                    }
                                    self.tableView.reloadData()
                                    self.loadingView.isHidden = true
                                    self.loadingView.stopAnimating()
                                    self.refreshControl.endRefreshing()

                                    if (isRefresh == true){
                                      /*  self.tableView.fadeOut(duration: 0.7, delay: 0.1, completion: { (finished) in
                                            if (finished == true){
                                                self.tableView.fadeIn(completion: {
                                                    (finished: Bool) -> Void in
                                                    
                                                })
                                            }
                                        })*/
                                      
                                        
                                    }
                                    
                                    
                                    //SHOULD BE DELETED
                                    //self.tab.removeAll()
                                    //self.tableView.reloadData()
                                    
                                    if (self.tab.count == 0){
                                        self.viewNoData.isHidden = false
                                    }else {
                                        self.viewNoData.isHidden = true
                                        
                                    }
                                    
                                   
        }) {
            (error) -> Void in
            self.loadingView.isHidden = true
            self.loadingView.stopAnimating()
            self.refreshControl.endRefreshing()
            
            if (self.tab.count == 0){
                self.viewNoData.isHidden = false
            }else {
                self.viewNoData.isHidden = true
                
            }
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
      self.performSegue(withIdentifier: "segueDetailsClientProduct", sender:  tab[indexPath.section].feeds[indexPath.row])
    }
  
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //FooterWallet
        let  footer : FooterWallet = Bundle.main.loadNibNamed("FooterWallet", owner: self, options: nil)?[0] as! FooterWallet
        //footer.roundCorners([.bottomLeft, .bottomRight], radius: 10)

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
        let v = gestureRecognizer.view!
        let tag = v.tag
        let item : Feed = tab[tag].feeds[tab[tag].feeds.count - 1]
        self.performSegue(withIdentifier: "segueDetailsClientProduct", sender:  item)
        print("Tapped")
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  header : HeaderWallet = Bundle.main.loadNibNamed("HeaderWallet", owner: self, options: nil)?[0] as! HeaderWallet
        
       // header.layer.masksToBounds = true
        //header.viewHeader.roundCorners([.topLeft, .topRight], radius: 10)
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
        
        /*     let deviceType = UIDevice.current.modelName
            
            print("device iphone -  Dashboard",deviceType)
            //if (deviceType.lowercased().trimmingCharacters(in: .whitespaces) == "iphone8,4" ) {
        if (deviceType.lowercased().trimmingCharacters(in: .whitespaces) == "iphone 5s"){
            return tableView.frame.width
        }
        */
        return 59
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 113
    }
    
 }
