
//
//  PromotionFeedClientViewController.swift
//  rep
//
//  Created by MacBook Pro on 07/09/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import KeychainSwift
class  PromotionFeedClientViewController2: ObjectFeedClientViewController  , UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var containerView: UIView!
    var tab : [String] = ["All"]
    let keychain = KeychainSwift()
    var tabFeed : [Feed] =  []
    var tabFeedSearch : [Feed] =  []
    
    var tabFeedCategoryDrink : [Feed] =  []
    var tabFeedSearchCategoryDrink : [Feed] =  []
    
    var tabFeedCategoryTicket : [Feed] =  []
    var tabFeedSearchCategoryTicket : [Feed] =  []
    
    var tabFeedCategoryFood : [Feed] =  []
    var tabFeedSearchCategoryFood : [Feed] =  []

    let fontClicked : UIFont  = UIFont(name: "Avenir Next", size: 23)!
    let fontDisCliked : UIFont  = UIFont(name: "Avenir Next", size: 17)!
    var currentIndexPager = 1
    var currentIndex = 0
    var preIndex = 0
    var withClick = false
    static var sharedCountSubMenuPromotionFeed : Int = 0
    static var sharedTabSubCategoryPromotionFeed : [String] = []
    var firstTime  : Bool = false

    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**************** PAger *******************/
    
    var tutorialPageViewController: PromotionPageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? PromotionPageViewController {
            self.tutorialPageViewController = tutorialPageViewController
            self.tutorialPageViewController?.client = self.client
            self.tutorialPageViewController?.tabMenuDrink = self.tabMenuDrink
            self.tutorialPageViewController?.tabFeedDrink = self.tabFeedDrink
        }
    }
    
    
}

extension PromotionFeedClientViewController2 {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        if (self.collectionView == collectionView){
            return tab.count
        }
        
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("indexPATH func \(indexPath.row)")
        
        if (self.collectionView == collectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCellPromotionPager", for: indexPath) as! myCellPromotionPager
            
            //
            let l : UILabel = cell.viewWithTag(101) as! UILabel
            l.text = tab[indexPath.row].uppercased()

            //Cell.selectionstyle = .none
            
            if (firstTime == false ){
                cell.lbl.font = self.fontClicked
                cell.lbl.textColor = UIColor(hexString : "#171033")
                firstTime = true
            }
            
            
            return cell
        }
        
        
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        if (self.collectionView == collectionView){
            
            let search : String = tab[indexPath.row]
            self.withClick = true
            
            
            if (search == "All"){
                self.tabFeedSearch = self.tabFeed
                self.tabFeedDrink = self.tabFeed
            } else {
                self.tabFeedSearch = []
                //  self.collectionViewData.reloadData()
                
                for k in tabFeed {
                    if (k.subcategory == search){
                        self.tabFeedSearch.append(k)
                    }
                }
                self.tabFeedDrink = self.tabFeedSearch
                
            }
            tutorialPageViewController?.scrollToViewController(index: indexPath.row)
            
            //self.collectionViewData.reloadData()
        }
        else {
            
            let popOverVC = UIStoryboard(name: "Acceuil", bundle: nil).instantiateViewController(withIdentifier: "Detail") as! PizzaDetailViewController
            popOverVC.feedPassed = tabFeedSearch[indexPath.row]
            self.present(popOverVC, animated: true, completion: nil)
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
        if (self.collectionView == collectionView){
            let search : String = tab[indexPath.row]
            if (collectionView.cellForItem(at : indexPath) != nil ){
                let cell = collectionView.cellForItem(at : indexPath) as! myCellPromotionPager
                cell.lbl.font =  fontDisCliked
                cell.lbl.textColor = UIColor(hexString : "#bdc3c7")
            }
            preIndex = indexPath.row
            
        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  collectionView.frame.width / 3 - 1
        
        return CGSize(width: width, height: width + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    
    
}

extension PromotionFeedClientViewController2: PromotionPageViewControllerDelegate {
    
    
    //getDataByCategoryFoods
    func getDataByCategoryFoods(category : String , wallet : String , token : String , client : Client){
        
        let params  =   ["wallet":"\(wallet)",
            "category":"\(category)"]
        let headers = ["Authorization":"Bearer \(token)"]
        
        //self.tabFeed = []
        //self.tableView.reloadData()
        print("params , \(params)")
        print("headers , \(headers)")
        print("Urls.CATAGORY_LIST = \(Urls.CATAGORY_LIST)")
        
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
                                        feed.info =  i["description"].string!

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
                                            
                                            print("--------------///////////_---------------------")
                                            print(i["name"])
                                            print(i["bulk"])
                                            
                                            
                                            feed.isBulk = true
                                            feed.bulk = i["bulk"].floatValue
                                            
                                        }
                                        
                                        
                                        
                                        
                                        
                                        self.tabFeedCategoryFood.append(feed)
                                        self.tabFeedSearchCategoryFood.append(feed)
                                        
                                    }
                                    AppDelegate.tabFeedCategoryFood = self.tabFeedCategoryFood
                                    AppDelegate.tabFeedSearchCategoryFood = self.tabFeedSearchCategoryFood

                                    //self.setSubCategory()
                                    //self.collectionView.reloadData()
                                    //self.collectionViewData.reloadData()
                                    
                                    /* print("will appear drink feed Client View Controller 2 .swift =  \(self.tab.count)")
                                     for k in self.tab{
                                     
                                     self.tutorialPageViewController?.orderedViewControllers.append((self.tutorialPageViewController?.newColoredViewController("PromotionFeedClientViewController2Data" , subMenu : k ))!)
                                     }
                                     
                                     self.tutorialPageViewController?.viewDidLoad()
                                     
                                     if (self.tab.count == 1){
                                     self.tutorialPageViewController?.dataSource = nil
                                     }*/
                                    
                                    
                                    
                                    
        }) {
            (error) -> Void in
            print(error)
        }
    }
    
    
    
    //getDataByCategoryTickets
    func getDataByCategoryTickets(category : String , wallet : String , token : String , client : Client){
        
        let params  =   ["wallet":"\(wallet)",
            "category":"\(category)"]
        let headers = ["Authorization":"Bearer \(token)"]
        
        //self.tabFeed = []
        //self.tableView.reloadData()
        print("params , \(params)")
        print("headers , \(headers)")
        print("Urls.CATAGORY_LIST = \(Urls.CATAGORY_LIST)")
        
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
                                        feed.info =  i["description"].string!

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
                                            
                                            print("--------------///////////_---------------------")
                                            print(i["name"])
                                            print(i["bulk"])
                                            
                                            
                                            feed.isBulk = true
                                            feed.bulk = i["bulk"].floatValue
                                            
                                        }
                                        
                                        
                                        
                                        
                                        
                                        self.tabFeedCategoryTicket.append(feed)
                                        self.tabFeedSearchCategoryTicket.append(feed)
                                        
                                    }
                                    AppDelegate.tabFeedCategoryTicket = self.tabFeedCategoryTicket
                                    AppDelegate.tabFeedSearchCategoryTicket = self.tabFeedSearchCategoryTicket
                                    
                                    //self.setSubCategory()
                                    //self.collectionView.reloadData()
                                    //self.collectionViewData.reloadData()
                                    
                                    /* print("will appear drink feed Client View Controller 2 .swift =  \(self.tab.count)")
                                     for k in self.tab{
                                     
                                     self.tutorialPageViewController?.orderedViewControllers.append((self.tutorialPageViewController?.newColoredViewController("PromotionFeedClientViewController2Data" , subMenu : k ))!)
                                     }
                                     
                                     self.tutorialPageViewController?.viewDidLoad()
                                     
                                     if (self.tab.count == 1){
                                     self.tutorialPageViewController?.dataSource = nil
                                     }*/
                                    
                                    
                                    
                                    
        }) {
            (error) -> Void in
            print(error)
        }
    }
    
    
    //getDataByCategoryDrinks
    func getDataByCategoryDrinks(category : String , wallet : String , token : String , client : Client){
        
        let params  =   ["wallet":"\(wallet)",
            "category":"\(category)"]
        let headers = ["Authorization":"Bearer \(token)"]
        
        //self.tabFeed = []
        //self.tableView.reloadData()
        print("params , \(params)")
        print("headers , \(headers)")
        print("Urls.CATAGORY_LIST = \(Urls.CATAGORY_LIST)")
        
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
                                        feed.info =  i["description"].string!

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
                                            
                                            print("--------------///////////_---------------------")
                                            print(i["name"])
                                            print(i["bulk"])
                                            
                                            
                                            feed.isBulk = true
                                            feed.bulk = i["bulk"].floatValue
                                            
                                        }
                                        
                                        
                                        
                                        
                                        
                                        self.tabFeedCategoryDrink.append(feed)
                                        self.tabFeedSearchCategoryDrink.append(feed)
                                        
                                        
                                        
                                    }
                                    AppDelegate.tabFeedCategoryDrink = self.tabFeedCategoryDrink
                                    AppDelegate.tabFeedSearchCategoryDrink = self.tabFeedSearchCategoryDrink

                                    
                                    //self.setSubCategory()
                                    //self.collectionView.reloadData()
                                    //self.collectionViewData.reloadData()
                                    
                                   /* print("will appear drink feed Client View Controller 2 .swift =  \(self.tab.count)")
                                    for k in self.tab{
                                        
                                        self.tutorialPageViewController?.orderedViewControllers.append((self.tutorialPageViewController?.newColoredViewController("PromotionFeedClientViewController2Data" , subMenu : k ))!)
                                    }
                                    
                                    self.tutorialPageViewController?.viewDidLoad()
                                    
                                    if (self.tab.count == 1){
                                        self.tutorialPageViewController?.dataSource = nil
                                    }*/
                                    
                                    
                                    
                                    
        }) {
            (error) -> Void in
            print(error)
        }
    }
    
    func getDataByCategory(category : String , wallet : String , token : String , client : Client){
        
        let params  =   ["wallet":"\(wallet)",
            "category":"\(category)"]
        let headers = ["Authorization":"Bearer \(token)"]
        
        //self.tabFeed = []
        //self.tableView.reloadData()
        print("params , \(params)")
        print("headers , \(headers)")
        print("Urls.CATAGORY_LIST = \(Urls.CATAGORY_LIST)")
        
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
                                        feed.info =  i["description"].string!

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
                                            
                                            print("--------------///////////_---------------------")
                                            print(i["name"])
                                            print(i["bulk"])
                                            
                                            
                                            feed.isBulk = true
                                            feed.bulk = i["bulk"].floatValue
                                            
                                        }
                                        
                                        
                                        
                                        
                                        
                                        self.tabFeed.append(feed)
                                        self.tabFeedSearch.append(feed)
                                        
                                    }
                                    self.setSubCategory()
                                    self.collectionView.reloadData()
                                    //self.collectionViewData.reloadData()
                                    AppDelegate.tabFeedCategoryPromotion = self.tabFeed
                                    AppDelegate.tabFeedSearchCategoryPromotion = self.tabFeedSearch
                                    print("will appear drink feed Client View Controller 2 .swift =  \(self.tab.count)")
                                    for k in self.tab{
                                        
                                        self.tutorialPageViewController?.orderedViewControllers.append((self.tutorialPageViewController?.newColoredViewController("PromotionFeedClientViewController2Data" , subMenu : k ))!)
                                    }
                                    
                                    self.tutorialPageViewController?.viewDidLoad()
                                    
                                    if (self.tab.count == 1){
                                        self.tutorialPageViewController?.dataSource = nil
                                    }
                                    
                                    
                                    
                                    
        }) {
            (error) -> Void in
            print(error)
        }
    }
    
    func setSubCategory(){
        
        
        for i in self.tabFeed {
            if (i.subcategory != ""){
                if (exitString(str: i.subcategory) == false){
                    self.tab.append(i.subcategory)
                }
                
            }
        }
        self.tabMenuDrink = self.tab
        PromotionFeedClientViewController2.sharedCountSubMenuPromotionFeed = self.tab.count
        PromotionFeedClientViewController2.sharedTabSubCategoryPromotionFeed = self.tab
    }
    
    func exitString ( str :  String) -> Bool{
        for i in self.tab{
            if ( i == str){
                return true
            }
        }
        return false
    }
    override func viewWillAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
        let token : String = self.keychain.get("token") as! String
        let wallet : String = self.keychain.get("wallet") as! String
        
        if (self.tutorialPageViewController?.i == 0){
            print("**************** FROM PROMOTIONS CLIENT Client : \(client?.name)")
            
            //Promotions
            getDataByCategory(category: "promotions", wallet: (client?.address)!, token: token , client : client!)
            //Drinks
            getDataByCategoryDrinks(category: "drinks", wallet: (client?.address)!, token: token , client : client!)
            //Tickets
            getDataByCategoryTickets(category: "ticket", wallet: (client?.address)!, token: token , client : client!)
            //Foods
            getDataByCategoryFoods(category: "food", wallet: (client?.address)!, token: token , client : client!)

            
            tutorialPageViewController?.i = (tutorialPageViewController?.i)! + 1
            print("**************** END PROMOTIONS CLIENT Client : \(client?.name)")
            //.
        }
        
        
    }
    func tutorialPageViewController(_ tutorialPageViewController: PromotionPageViewController,
                                    didUpdatePageCount count: Int) {
        //  pageControl.numberOfPages = count
        print("******************************** count  \(count)")
    }
    
    func tutorialPageViewController(_ tutorialPageViewController: PromotionPageViewController,
                                    didUpdatePageIndex index: Int) {
        //pageControl.currentPage = index
        print("******************************** index  \(index) ***************** \(currentIndex)")
        
        let x = preIndex
        self.preIndex = currentIndex
        currentIndex = index
     
        if (currentIndex != preIndex){
            
            
            if (tabFeedSearch.count != 0){
                print("currentIndex = \(currentIndex)")
                print("preIndex = \(preIndex)")
                /*
                if (preIndex == (self.tab.count - 1) ) {
                    print("ENTER   (preIndex == (self.tab.count - 1) )  ")
                    self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }else  if ( preIndex == 0) {
                    print("ENTER   ( preIndex == 0)  ")
                    self.collectionView.scrollToItem(at: IndexPath(row: (self.tab.count - 1), section: 0), at: .bottom, animated: true)

                }
                else {
                    print("ENTER   else ")

                    self.collectionView.scrollToItem(at:  IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)

                }
                
                
                if ( self.collectionView.cellForItem(at : IndexPath(row: index, section: 0) )  != nil){
                    let cellCurrentIndex = self.collectionView.cellForItem(at : IndexPath(row: index, section: 0) ) as! myCellPromotionPager
                    cellCurrentIndex.lbl.font = fontClicked
                    cellCurrentIndex.lbl.textColor = UIColor(hexString : "#171033")
                }
                
                
                if (self.collectionView.cellForItem(at : IndexPath(row: preIndex, section: 0) ) != nil ){
                    let cellPreIndex = self.collectionView.cellForItem(at : IndexPath(row: preIndex, section: 0) ) as! myCellPromotionPager
                    cellPreIndex.lbl.font =  fontDisCliked
                    cellPreIndex.lbl.textColor = UIColor(hexString : "#bdc3c7")
                }
                */
                self.collectionView.deselectAllItems()
                
                if (tab.count == index+1){
                    self.collectionView.selectItem(at: IndexPath(row: index, section: 0)  , animated: true, scrollPosition: .centeredHorizontally )
                    
                    let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        // Your code with delay
                        let cellCurrentIndex = self.collectionView.cellForItem(at : IndexPath(row: index, section: 0) ) as! myCellPromotionPager
                        cellCurrentIndex.lbl.font = self.fontClicked
                        cellCurrentIndex.lbl.textColor = UIColor(hexString : "#171033")
                    }
                    if (self.collectionView.cellForItem(at : IndexPath(row: tab.count-2, section: 0) ) != nil ){
                        let cellPreIndex = self.collectionView.cellForItem(at : IndexPath(row: preIndex, section: 0) ) as! myCellPromotionPager
                        cellPreIndex.lbl.font =  fontDisCliked
                        cellPreIndex.lbl.textColor = UIColor(hexString : "#bdc3c7")
                    }
                    if (self.collectionView.cellForItem(at : IndexPath(row: 0, section: 0) ) != nil ){
                        let cellPreIndex = self.collectionView.cellForItem(at : IndexPath(row: preIndex, section: 0) ) as! myCellPromotionPager
                        cellPreIndex.lbl.font =  fontDisCliked
                        cellPreIndex.lbl.textColor = UIColor(hexString : "#bdc3c7")
                    }
                    
                    
                }else if (index == 0){
                    
                    self.collectionView.selectItem(at: IndexPath(row: index, section: 0)  , animated: true, scrollPosition: .centeredHorizontally )
                    let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        // Your code with delay
                        let cellCurrentIndex = self.collectionView.cellForItem(at : IndexPath(row: index, section: 0) ) as! myCellPromotionPager
                        cellCurrentIndex.lbl.font = self.fontClicked
                        cellCurrentIndex.lbl.textColor = UIColor(hexString : "#171033")
                    }
                    
                    if (self.collectionView.cellForItem(at : IndexPath(row: 1, section: 0) ) != nil ){
                        let cellPreIndex = self.collectionView.cellForItem(at : IndexPath(row: preIndex, section: 0) ) as! myCellPromotionPager
                        cellPreIndex.lbl.font =  fontDisCliked
                        cellPreIndex.lbl.textColor = UIColor(hexString : "#bdc3c7")
                    }
                    if (self.collectionView.cellForItem(at : IndexPath(row: tab.count-1, section: 0) ) != nil ){
                        let cellPreIndex = self.collectionView.cellForItem(at : IndexPath(row: preIndex, section: 0) ) as! myCellPromotionPager
                        cellPreIndex.lbl.font =  fontDisCliked
                        cellPreIndex.lbl.textColor = UIColor(hexString : "#bdc3c7")
                    }
                    
                    
                }else {
                    self.collectionView.scrollToItem(at:  IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
                    if ( self.collectionView.cellForItem(at : IndexPath(row: index, section: 0) )  != nil){
                        let cellCurrentIndex = self.collectionView.cellForItem(at : IndexPath(row: index, section: 0) ) as! myCellPromotionPager
                        cellCurrentIndex.lbl.font = fontClicked
                        cellCurrentIndex.lbl.textColor = UIColor(hexString : "#171033")
                    }
                    if (self.collectionView.cellForItem(at : IndexPath(row: preIndex, section: 0) ) != nil ){
                        let cellPreIndex = self.collectionView.cellForItem(at : IndexPath(row: preIndex, section: 0) ) as! myCellPromotionPager
                        cellPreIndex.lbl.font =  fontDisCliked
                        cellPreIndex.lbl.textColor = UIColor(hexString : "#bdc3c7")
                    }
                }
            }
            
        }
        withClick = false
        
    }
    
}

