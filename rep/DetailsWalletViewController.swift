//
//  DetailsWalletViewController.swift
//  rep
//
//  Created by MacBook Pro on 03/09/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import QRCode
import KeychainSwift
import SCLAlertView
import MapKit
class DetailsWalletViewController: UIViewController {
    let keychain = KeychainSwift()
    var feed : Feed? = nil
    @IBOutlet weak var feedName: UILabel!
    @IBOutlet weak var subViewMainQRCode: UIView!
    @IBOutlet weak var imageViewAnimation: UIImageView!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var mainQrCodeView: UIView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var infoAsset: UITextView!

    @IBOutlet weak var btnORDERTOTABLE: UIButton!
    @IBOutlet weak var btnREDEEMNOW: UIButton!
    @IBOutlet weak var viewImageViewD: UIView!
    @IBOutlet weak var imageFeed: UIImageView!
    @IBOutlet weak var topname: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var numberPerBalance: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var optionsList = [String]()

    var strTable : String = ""
    var position : Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
  
        // Do any additional setup after loading the view.
      viewImageViewD.layer.cornerRadius = 5
       // viewImageViewD.layer.masksToBounds = true
        feedName.text = feed?.name
       
        
        
        //Hero animation for transations
        feedName.heroID = "wallet\((feed?.name)!)\((feed?.modifiers)!)"
        imageFeed.heroID = "wallet\((feed?.iconUrl)!)\((feed?.modifiers)!)"
        
        
        infoAsset.text = feed?.info
        
        
        
        let currentLocation = CLLocationCoordinate2DMake(AppDelegate.currentLocaitonLatitude, AppDelegate.currentLocaitonLongitude)
        /********* Distance ************/


        let lat0 : Double =  Double.init("\(currentLocation.latitude)")!

        let lon0 : Double =  Double.init("\(currentLocation.longitude)")!
     
        let lat1 : Double =  Double.init("\(feed!.client.latitude)")!

        let lon1 : Double =  Double.init("\(feed!.client.longitude)")!

        let coordinate0 = CLLocation(latitude: lat0, longitude: lon0)

        let coordinate1 = CLLocation(latitude: lat1, longitude: lon1)

        let distanceMilles = ( (coordinate1.distance(from: coordinate0)) / 1609.344 )

        let distanceInMeters = "\(distanceMilles)"
        if let range = distanceInMeters.range(of: ".") {
            let firstPart = distanceInMeters[distanceInMeters.startIndex..<range.lowerBound]
            print(firstPart) // print Hello
            // cell.sizeObj.text = "\(firstPart)mi"

            topname.text = "\((feed?.client.name)!) - \(firstPart)mi"

        }

        
        
        
        
        
        //imageFeed
        if let url = URL.init(string: (feed?.iconUrl)!) {
            imageFeed.af_setImage(withURL: url,imageTransition: .crossDissolve(0.5))
            imageFeed.contentMode = .scaleToFill

        }
        numberPerBalance.text = "1/\(feed!.balance)"
        slider.maximumValue = (feed?.balance.floatValue)!
        slider.minimumValue = 1
        

        slider.setValue(1, animated: false)

        
     //  mainQrCodeView.isHidden = true
        
        viewImageViewD.layer.cornerRadius = 5
        viewImageViewD.layer.masksToBounds = true
        
        imageFeed.layer.cornerRadius = 5
        imageFeed.layer.masksToBounds = true
        

        
//        subViewMainQRCode.layer.cornerRadius = 5
//        subViewMainQRCode.layer.shadowOpacity =  1
//        subViewMainQRCode.layer.shadowRadius = 10
//        subViewMainQRCode.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        subViewMainQRCode.layer.shadowColor = UIColor.black.cgColor
//        
//        
//        mainQrCodeView.layer.cornerRadius = 5
//        mainQrCodeView.layer.masksToBounds = true
//        
//        
        btnREDEEMNOW.layer.cornerRadius = 5
        btnREDEEMNOW.layer.masksToBounds = true
        
        
        
        btnORDERTOTABLE.layer.cornerRadius = 5
        btnORDERTOTABLE.layer.masksToBounds = true
        
   NotificationCenter.default.addObserver(self, selector: #selector(self.showSpinningWheel(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
        
    }
    func showSpinningWheel(_ notification: NSNotification) {
        print("Received Notification")
        strTable = notification.userInfo?["text"] as! String
        print("******* strTable = \(strTable)")
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        print("************** DID LOAD VIEW INTRO")
       /*
        DispatchQueue.global(qos: .background).async { // 1
            
            DispatchQueue.main.async { // 2
                self.startAnimationCloud1()
                self.startAnimationCloud2()
                self.startAnimationCloud3()
            }
        }*/
    }
 
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnREDEEMNOWAction(_ sender: Any) {
//        mainQrCodeView.isHidden = false
//        //imgQRCode
//        let wallet : String = self.keychain.get("wallet")!
//
//         imgQRCode.image = {
//            var qrCode = QRCode("\(wallet) \(feed?.balance)")!
//            qrCode.size = self.imgQRCode.bounds.size
//            qrCode.errorCorrection = .High
//           // qrCode.backgroundColor = UIColor(hexString: "#1D7CE3").ciColor
//
//            return qrCode.image
//        }()
        print(feed?.iconUrl)
    let popOverVC = UIStoryboard(name: "Wallet", bundle: nil).instantiateViewController(withIdentifier: "popUpQRCode") as! popUpQRCode
        popOverVC.urlImage = self.feed!.iconUrl
        popOverVC.feed = self.feed
        popOverVC.Quantity = Int(slider.value.rounded(.toNearestOrAwayFromZero))
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    @IBAction func closeREDEEMNOW(_ sender: Any) {
      //  mainQrCodeView.isHidden = true
    }
   
    func startAnimationCloud1(){
        
        
        UIView.animate(withDuration: 16, delay: 0, options: [.repeat, .autoreverse] , animations: {
            self.cloud1.center.x += self.view.bounds.width
        }) { (Bool) in
            //
        }
        
    }
    
    
    func startAnimationCloud2(){
        UIView.animate(withDuration: 16, delay: 0, options: [.repeat, .autoreverse] , animations: {
            self.cloud2.center.x -= self.view.bounds.width
        }) { (Bool) in
            //
        }
        
        
    }
    
    
    func startAnimationCloud3(){
        UIView.animate(withDuration: 16, delay: 0, options: [.repeat, .autoreverse] , animations: {
            self.cloud3.center.x += self.view.bounds.width
        }) { (Bool) in
            //
        }
        
        
    }
    /**************** PAger 2 *******************/
    @IBAction func sliderAction(_ sender: Any) {
        slider.setValue(slider.value.rounded(.toNearestOrAwayFromZero), animated: true)
        numberPerBalance.text = "\(Int(slider.value.rounded(.toNearestOrAwayFromZero)))/\(feed!.balance)"
    }

    
    
    @IBAction func orderToTableAction(_ sender: Any) {
        
        //[{"address": hash, "quantity": 123, "modifiers": ["single", "double", "ketchup"]}
    /*   */
        if ((Int(slider.value.rounded(.toNearestOrAwayFromZero))) == 0){
            Utils.snackBar(message: "Please select quantity of \(feed!.name)")
        }else {
            let popOverVC = UIStoryboard(name: "Wallet", bundle: nil).instantiateViewController(withIdentifier: "popUpAddTableViewController") as! popUpAddTableViewController
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            popOverVC.feed = self.feed
            popOverVC.slider = Int(slider.value.rounded(.toNearestOrAwayFromZero))
            popOverVC.optionsList = optionsList
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
            /************** End Check your network *************/
        }
      
    }
}

extension DetailsWalletViewController :  UICollectionViewDelegate , UICollectionViewDataSource {
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        /************************ Reader Modifiers ****************/
        
        for data in feed!.modifiers.array! {
            
            for (key, value) in data {
                
                optionsList.append(key)
                //MinMaxList.append(value)
                
                
                for (key2,value2) in value{
                    
                    
                    
                    if key2 == "min_modifiers" || key2 == "max_modifiers" {
                        
                    }
                    else {
                        print("*************** Modifiers : \(key2)")
                        optionsList.append(key2)
                        // TMPPickerNumberList.append(value2.string!)
                        
                    }
                    
                }
                //PickerNameList.append(TMPPickerNameList)
                //PickerNumberList.append(TMPPickerNumberList)
                
            }
            
            //self.tableViez.reloadData()
            
        }
        
        print(" LIST FINAL Count : \(optionsList.count)")
        /**********************************************************/
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return optionsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath)
        let labelTxt : UILabel = cell.viewWithTag(100) as! UILabel
        labelTxt.text = optionsList[indexPath.row]
        cell.layer.cornerRadius = 20
        cell.layer.shadowColor = UIColor.blue.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.3
        //cell.backgroundColor = UIColor.init(hexString: "002f4c")
        labelTxt.textColor = UIColor.white
        return cell
    }
    
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
 
    
}
