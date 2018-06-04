
//
//  PromotionFeedClientViewController.swift
//  rep
//
//  Created by MacBook Pro on 07/09/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import KeychainSwift
import NVActivityIndicatorView
import Lottie
class DrinkFeedClientViewController2Data: ObjectFeedClientViewController  , UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NVActivityIndicatorViewable{
    @IBOutlet weak var containerView: UIView!
    var tab : [String] = ["All"]
    let keychain = KeychainSwift()
    var tabFeedXXXXXXX : [Feed] =  []
    var tabFeedSearch : [Feed] =  []
    let fontClicked : UIFont  = UIFont(name: "Avenir Next", size: 23)!
    let fontDisCliked : UIFont  = UIFont(name: "Avenir Next", size: 17)!
    var subMenu : String = ""
    
    
    //Lottie
    @IBOutlet weak var viewNoData: UIView!
    @IBOutlet weak var lottieView: UIView!
    
    
    @IBOutlet weak var collectionViewData: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        collectionViewData.delegate = self
        collectionViewData.dataSource = self
        // Do any additional setup after loading the view.
        let token : String = self.keychain.get("token") as! String
        let wallet : String = self.keychain.get("wallet") as! String
        
        
        print("**************** FROM PROMOTIONS CLIENT Client :xwxcwxcwxc wxc wxc wxc  \(subMenu)")
        
        //getDataByCategory(category: "drinks", wallet: (client?.address)!, token: token , client : client! , cat : subMenu)
        
        for feed in AppDelegate.tabFeedCategoryDrink{
            if (self.subMenu == "All"){
                self.tabFeedXXXXXXX.append(feed)
            }else if (feed.subcategory == self.subMenu){
                self.tabFeedXXXXXXX.append(feed)
            }
            
        }
        self.setSubCategory()
        self.collectionViewData.reloadData()
        
        
        print("**************** END PROMOTIONS CLIENT Client : \(client?.name)")
        
        
        // Lottie
      /*  let animationView = LOTAnimationView(name: "empty_list")
        animationView.frame = self.lottieView.bounds
        animationView.bounds = self.lottieView.bounds
        animationView.contentMode = .scaleAspectFill
        self.lottieView.addSubview(animationView)
        animationView.loopAnimation = true
        animationView.pause()*/

        if (self.tabFeedXXXXXXX.count == 0){
            viewNoData.isHidden = false
        }else {
            viewNoData.isHidden = true
            
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
       
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**************** PAger *******************/
    
}

extension DrinkFeedClientViewController2Data {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        if (collectionViewData == collectionView){
            return self.tabFeedXXXXXXX.count
        }
      
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if (collectionViewData == collectionView){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellDrinkFeedClient", for: indexPath) as! cellDrinkFeedClient
            //     let obj  : [String : String] = price[indexPath.row] as! [String : String]
            //    let oldPrice : String = obj["OldPrice"]!
            //    let newPrice : String = obj["NewPrice"]!
            /*   if (indexPath.row != 2){
             
             cell.oldPrice.text = oldPrice
             cell.newPrice.text = newPrice
             cell.price.isHidden = true
             } else {*/
            cell.price.text =  "£ \(self.tabFeedXXXXXXX[indexPath.row].price)"
            cell.name.text = self.tabFeedXXXXXXX[indexPath.row].name
            cell.oldPrice.isHidden = true
            cell.newPrice.isHidden = true
            if let url = URL.init(string: self.tabFeedXXXXXXX[indexPath.row].iconUrl) {
                cell.img.af_setImage(withURL: url,imageTransition: .crossDissolve(0.5))
                cell.img.contentMode = .scaleToFill

            }
            
            
            //Hero animation for transations
            cell.img!.heroID = self.tabFeedXXXXXXX[indexPath.row].iconUrl
            cell.name.heroID = self.tabFeedXXXXXXX[indexPath.row].name
            cell.price.heroID =  "price\(self.tabFeedXXXXXXX[indexPath.row].name)"
            
            
            // }
            // cell.img.image = UIImage(named: tabImage[indexPath.row])
            
            //
            
            return cell
            
        }
       
        
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
            
            
            let popOverVC = UIStoryboard(name: "Acceuil", bundle: nil).instantiateViewController(withIdentifier: "Detail") as! PizzaDetailViewController
            popOverVC.feedPassed = self.tabFeedXXXXXXX[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? cellDrinkFeedClient
        
        popOverVC.productImage = cell?.img.image
        
            self.present(popOverVC, animated: true, completion: nil)
            
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
       
        
        
        
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
    
    func getDataByCategory(category : String , wallet : String , token : String , client : Client , cat : String){
        
        let size = CGSize(width: 90, height: 90)
        self.startAnimating(size, message: "Loading...", type: NVActivityIndicatorType(rawValue: 22)!)
        
        let params  =   ["wallet":"\(wallet)",
            "category":"\(category)"]
        let headers = ["Authorization":"Bearer \(token)"]
        
        self.tabFeedXXXXXXX = []
        print("params , \(params)")
        print("headers , \(headers)")
        print("Urls.CATAGORY_LIST = \(Urls.CATAGORY_LIST)")
        
        AFWrapper.requestPOSTURL(Urls.CATAGORY_LIST, params: params, headers: headers,
                                 success: {
                                    (JSONResponse) -> Void in
                                    

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
                                        
                                        if (self.subMenu == "All"){
                                            self.tabFeedXXXXXXX.append(feed)
                                        }else if (feed.subcategory == self.subMenu){
                                            self.tabFeedXXXXXXX.append(feed)
                                        }
                                    
                                        
                                        
                                        
                                        if (i["bulk"] == nil) {
                                            
                                            
                                        }else {
                                            feed.isBulk = true
                                            feed.bulk = i["bulk"].floatValue
                                            
                                        }
                                     
                                            
                                   
                                        }
                                       
                                        
                                    print("**************** END PROMOTIONS CLIENT Client : \(client.name)")

                                    print("fuck fuck fuck fuck fuck fuck fuck \(self.tabFeedXXXXXXX.count)")
                                    self.setSubCategory()
                                    self.collectionViewData.reloadData()
                                    self.stopAnimating()
                                    
                                    
                                    
                                    
                                    
        }) {
            (error) -> Void in
            print(error)
            self.stopAnimating()
        }
    }
    
    func setSubCategory(){
        
        
        for i in self.tabFeedXXXXXXX {
            if (i.subcategory != ""){
                if (exitString(str: i.subcategory) == false){
                    self.tab.append(i.subcategory)
                }
                
            }
        }
        
        
    }
    
    func exitString ( str :  String) -> Bool{
        for i in self.tab{
            if ( i == str){
                return true
            }
        }
        return false
    }
    
    
    
}


