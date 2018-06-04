//
//  PizzaDetailViewController.swift
//  rep
//
//  Created by bechir Kaddech on 8/30/17.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import  SwiftyJSON
import Hero
import MapKit
import Lottie
import AlamofireImage
import Instructions
import SCLAlertView


class PizzaDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate,CoachMarksControllerDataSource,CoachMarksControllerDelegate {
    
    @IBOutlet weak var backetActionView: UIView!
    @IBOutlet weak var closeActionVIEW: UIView!
    @IBOutlet weak var venuBTN: UIButton!
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var closeBTN: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var infoText: UITextView!
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var priceText: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    let manager = CLLocationManager()
    let annotation = MKPointAnnotation()
    @IBOutlet weak var optionCollectionView: UITableView!
    

    @IBOutlet weak var tableViez: UITableView!
    
    @IBOutlet weak var basketCount: UILabel!
    var pickedModifiers  : [[String : String]] = []
    
    @IBOutlet weak var buyBTN: UIButton!
    
    @IBOutlet weak var venueBTN: UIButton!
    
    var feedPassed : Feed? = nil
    
    var optionsList = [String]()
    var PickerNameList = [[String]]()
    var PickerNumberList = [[String]]()
    
    var totalPrice : Float = 0.00
    var priceOfOne : Float = 0.00
    
    var MinMaxList :[JSON] = []
    
    var maxPick : String = ""
    var minPick : String = ""
    
    var productImage : Image!
    
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var quantity: UILabel!
    
    var numberProduct : Float = 1
    
    override func viewWillAppear(_ animated: Bool) {

        picture.image = productImage
         basketCount.text = "\(MarcketChart.chartArray.count)"
        
        
        self.coachMarksController.dataSource = self
        
      //
        
        
        
        let launchedBeforePizza = UserDefaults.standard.bool(forKey: "launchedBeforePizza")
        if launchedBeforePizza  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBeforePizza")
           self.coachMarksController.start(on: self)
        }
        

        
        
    }
    

    
    
    
    //tour guide methodes and delegate
    let coachMarksController = CoachMarksController()
    
    
    
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 3
    }
    
    
    
    
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        
        var coachMark : CoachMark
        
        switch(index) {
            
        case 0:
            coachMark = coachMarksController.helper.makeCoachMark(for: self.quantityView)
            coachMark.arrowOrientation = .bottom
            
        case 1:
            coachMark = coachMarksController.helper.makeCoachMark(for: self.buyBTN)
            coachMark.arrowOrientation = .bottom
            
        case 2:
            coachMark = coachMarksController.helper.makeCoachMark(for: self.venuBTN)
            coachMark.arrowOrientation = .top
    
            
            
        default:
            coachMark = coachMarksController.helper.makeCoachMark()
            
            
        }
        
        return coachMark
        
    }
    
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        
        let coachMarkBodyView = CustomCoachMarkBodyView()
        var coachMarkArrowView: CustomCoachMarkArrowView? = nil
        
        var width: CGFloat = 0.0
        
        switch(index) {
        case 0:
            coachMarkBodyView.hintLabel.text = "Select how much you want!."
            coachMarkBodyView.highlighted = true
            coachMarkBodyView.nextButton.setTitle("ok!", for: .normal)
            if let quantityView = self.quantityView {
                width = quantityView.bounds.width
            }
        case 1:
            coachMarkBodyView.hintLabel.text = "Added product to your basket."
            //  coachMarkBodyView.highlighted = true
            coachMarkBodyView.nextButton.setTitle("ok!", for: .normal)
            if let buyBTN = self.buyBTN {
                width = buyBTN.bounds.width
            }
            
        case 2:
            coachMarkBodyView.hintLabel.text = "View more from this venue."
            //  coachMarkBodyView.highlighted = true
            coachMarkBodyView.nextButton.setTitle("ok!", for: .normal)
            if let venuBTN = self.venuBTN {
                width = venuBTN.bounds.width
            }
            
 
            
            
            
        default: break
            
            
        }
        

        //draw the arrow
        if let arrowOrientation = coachMark.arrowOrientation {
            coachMarkArrowView = CustomCoachMarkArrowView(orientation: arrowOrientation)

            // If the view is larger than 1/3 of the overlay width, we'll shrink a bit the width
            // of the arrow.
            let oneThirdOfWidth = self.view.frame.size.width / 3
            let adjustedWidth = width >= oneThirdOfWidth ? width - 2 * coachMark.horizontalMargin : width

            coachMarkArrowView!.plate.addConstraint(NSLayoutConstraint(item: coachMarkArrowView!.plate, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: adjustedWidth))
        }

        
        return (bodyView: coachMarkBodyView, arrowView: coachMarkArrowView)
    }
    


    
    
    override func viewDidLayoutSubviews() {
        
//        self.optionCollectionViewDetails.flashScrollIndicators()

    }
    
    func closeActionVIEW(sender : UITapGestureRecognizer) {
        // Do what you want
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    func backetActionView(sender : UITapGestureRecognizer){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Acceuil", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Chart")
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.closeActionVIEW(sender:)))
        self.closeActionVIEW.addGestureRecognizer(gesture)
        
        //backetActionView
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector (self.backetActionView(sender:)))
        self.backetActionView.addGestureRecognizer(gesture2)
        
        

        picture.heroID = feedPassed!.iconUrl
        name.heroID = feedPassed!.name
        priceText.heroID =  "price\(feedPassed!.name)"
        venueBTN.setTitle("@\(feedPassed!.client.name) \(feedPassed!.client.lastname)", for: .normal)
        infoText.text = feedPassed!.info
        
 
    
        for data in feedPassed!.modifiers.array! {
            
            for (key, value) in data {
                
                optionsList.append(key)
                MinMaxList.append(value)
                
                var TMPPickerNameList = [String]()
                var TMPPickerNumberList = [String]()
                
                for (key2,value2) in value{
                    
                    
                    
                    if key2 == "min_modifiers" || key2 == "max_modifiers" {
                        
                    }
                    else {
                        TMPPickerNameList.append(key2)
                        TMPPickerNumberList.append(value2.string!)
                        
                    }
                    
                }
                PickerNameList.append(TMPPickerNameList)
                PickerNumberList.append(TMPPickerNumberList)
                
            }
            
            self.tableViez.reloadData()
            
        }
        
        
        
        
        
        
    
        
    
        
        
        bottomView.layer.cornerRadius = 15
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowRadius = 6
        bottomView.layer.shadowColor = UIColor.black.cgColor
        
        
        priceText.text = "£\(feedPassed!.price)"
        totalPrice = feedPassed!.price.floatValue
        name.text = feedPassed!.name
        
 
        
        quantity.text = "\(numberProduct.cleanValue)"
        
        
        
        
        
        
        
    
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updatePrice(_:)), name: NSNotification.Name(rawValue: "updatePrice"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reducePrice(_:)), name: NSNotification.Name(rawValue: "reducePrice"), object: nil)
        
        
        
        
    }
    
    func updatePrice(_ notification: NSNotification) {
        
        let  recivedPrice = notification.userInfo?["price"] as? String
        let recivedName = notification.userInfo?["name"] as? String
        
        let modifier : [String : String] = [ recivedName as! String : recivedPrice as! String]

        totalPrice = totalPrice + ((recivedPrice?.floatValue)! * numberProduct )
        
        priceText.text = "£ \(totalPrice)"
        
        
        print("------------modifier---------")
        print(modifier)
        
        pickedModifiers.append(modifier)
        print(pickedModifiers.count)
      
        
        
        
    }
    
    func reducePrice(_ notification: NSNotification) {
        
        let  recivedPrice = notification.userInfo?["price"] as? String
        let recivedName = notification.userInfo?["name"] as? String
        totalPrice = totalPrice - ((recivedPrice?.floatValue)! * numberProduct )
        
        priceText.text = "£ \(totalPrice)"
        
        let modifier : [String : String] = [ recivedName as! String : recivedPrice as! String]

        
        
        for i in 0 ..< pickedModifiers.count {
           
            if (pickedModifiers[i] == modifier ){
                print("found at")
                print(i)
                print(pickedModifiers.count)
                 pickedModifiers.remove(at: i)
                print("after remove")

                print(pickedModifiers.count)
                break

                
            }
            else {
                print("flase")
            }
            
        }
        
      
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsList.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath) as! OptionsTableViewCell
        // let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath)
        
        cell.selectionStyle = .none
        
        let MinMaxList : JSON = self.MinMaxList[indexPath.row]
        
        print ("JSON FORMAT")
        print(MinMaxList)
        
        cell.testLabel?.text = optionsList[indexPath.row]
        
        cell.minLabel.text = "Min \(MinMaxList["min_modifiers"].string!)"
        cell.maxLabel.text = "Max \(MinMaxList["max_modifiers"].string!)"
        
        cell.fillCollectionViewNames(with: PickerNameList[indexPath.row])
        cell.fillCollectionViewNumber(with: PickerNumberList[indexPath.row])
        cell.setMax(with: MinMaxList["max_modifiers"].string!)
        cell.setMin(with: MinMaxList["min_modifiers"].string!)
        
        
        
        
        return cell
        
    }
    
    
    @IBAction func basketAction(_ sender: Any) {
        
        
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Acceuil", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Chart")
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    @IBAction func plusAction(_ sender: Any) {
        priceOfOne = totalPrice / numberProduct
        numberProduct = numberProduct + 1
        quantity.text = "\(numberProduct.cleanValue)"
        totalPrice = totalPrice + priceOfOne
        
        priceText.text = "£ \(totalPrice)"
        
        
        
        
    }
    
    @IBAction func minusAction(_ sender: Any) {
        if numberProduct == 1 {
            
        }
        else {
            priceOfOne = totalPrice / numberProduct
            
            numberProduct = numberProduct - 1
            quantity.text = "\(numberProduct.cleanValue)"
            
            totalPrice = totalPrice - priceOfOne
            
            priceText.text = "£ \(totalPrice)"
        }
        
        
    }
    
    
    @IBAction func venuAction(_ sender: Any) {
        
         performSegue(withIdentifier: "segueProductClient", sender: self.feedPassed?.client)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "segueProductClient"){
            let svc : DetailsLiveFeed2ViewController = segue.destination as! DetailsLiveFeed2ViewController
            svc.client = sender as! Client
        }
        
    }
    
    
    
    @IBAction func buyAction(_ sender: Any) {
        
        if (feedPassed!.client.purchases == "1"){
        
        let chart = Chart()
        chart.name = feedPassed!.name
        chart.price = totalPrice
        chart.total = numberProduct
        chart.modifiers = pickedModifiers
        chart.path = feedPassed!.asset
        chart.issuer  = feedPassed!.client.address
        chart.isBulk = feedPassed!.isBulk
        chart.bulk = feedPassed!.bulk
        MarcketChart.chartArray.append(chart)
           
            performSegue(withIdentifier: "buyAsset", sender: nil)

        }
        else {
            
            
            
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("Ok") {
                alertView.hideView()
                
                
                
            }
            
            alertView.showInfo("Try again later!", subTitle: "Business has not allowed purchases yet!")
            

            
            
            
        }
        
        
    }
    
    
    @IBOutlet weak var minusAction: UIButton!
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        
    }
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        print("rendering is finished")
    
    }
    
 
    
 
    
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        optionCollectionView.flashScrollIndicators()
        

        


        print("************** DID LOAD VIEW INTRO")
//
//        DispatchQueue.global(qos: .background).async { // 1
//
//            DispatchQueue.main.async { // 2
//                self.startAnimationCloud1()
//                self.startAnimationCloud2()
//                self.startAnimationCloud3()
//            }
//        }
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
    
    
}
extension Float {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
