//
//  ChartViewController.swift
//  rep
//
//  Created by bechir kaddech on 9/10/17.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import Hero
import NVActivityIndicatorView
import KeychainSwift
import SCLAlertView
import ElasticTransition
import Lottie

class ChartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NVActivityIndicatorViewable {

    @IBOutlet weak var animationView: UIView!
    @IBOutlet var emptyBasket: UIView!
    @IBOutlet weak var basketCount: UILabel!
    @IBOutlet weak var cardLastNumbers: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    var token : String = ""
    let keychain = KeychainSwift()

    var transition = ElasticTransition()

    var totalPrice : Float = 0.0
    
    private var gradient: CAGradientLayer!

    @IBOutlet weak var bascketView: UIView!
    
    @IBOutlet weak var closeView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        basketCount.text = "\(MarcketChart.chartArray.count)"
        
    }
    
    func closeViewAction( sender : UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
    func bascketViewAction( sender : UITapGestureRecognizer ){
        //bascketView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.closeViewAction(sender:)))
        self.closeView.addGestureRecognizer(gesture)
        
        //bascketView
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector (self.bascketViewAction(sender:)))
        self.bascketView.addGestureRecognizer(gesture2)
        
        
        
        if(MarcketChart.chartArray.count == 0) {
            
            
   
            //this for testing 
            emptyBasket.frame = self.view.bounds
            emptyBasket.clipsToBounds = true
            self.view.addSubview(emptyBasket)
            
            
      
            
            
        }else {
            
            
            // Do any additional setup after loading the view.
            
            bottomView.layer.cornerRadius = 10
            bottomView.layer.shadowOpacity = 1
            bottomView.layer.shadowRadius = 6
            bottomView.layer.shadowColor = UIColor.black.cgColor
            
            
            //transition customization
            transition.sticky = true
            transition.showShadow = true
            transition.panThreshold = 0.3
            transition.radiusFactor = 8
            transition.transformType = .translateMid
            
            
            
            
            
            
            token = self.keychain.get("token") as! String
            
            self.totalLabel.text = "£ \(totalPrice)"
            
            for chart in MarcketChart.chartArray {
                
                
                self.totalPrice = totalPrice + chart.price
                print("\(totalPrice)")
                
                self.totalLabel.text = "£ \(totalPrice)"
                
            }
            
            getMaskedCard()
            
        }
        
        
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
      //  gradient.frame = view.bounds
        
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
    
    
    
    @IBAction func startAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination
        vc.transitioningDelegate = transition
        vc.modalPresentationStyle = .custom
        
    
        
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MarcketChart.chartArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if (MarcketChart.chartArray[indexPath.row].modifiers.count == 0) {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChartCellSmall", for: indexPath) as! SmallChartTableViewCell
            
            cell.selectionStyle = .none
            
            
            let chart = MarcketChart.chartArray[indexPath.row]
            
            cell.name.text = chart.name 
            cell.price.text = "£ \(chart.price)"
            cell.quantity.text = "\(chart.total.cleanValue)"

                cell.name.heroID = chart.name
                cell.price.heroID =  "price\(chart.name)"
         
            
         
            
        
            
            cell.delete.addTarget(self, action: #selector(self.delete(sender:)), for: .touchUpInside)
            cell.delete.tag = indexPath.row
 
            
            return cell
            
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChartCell", for: indexPath) as! ChartTableViewCell
            
            cell.selectionStyle = .none
            
            
            let chart = MarcketChart.chartArray[indexPath.row]
            
            cell.itemName.text = chart.name
            cell.price.text = "£ \(chart.price)"
            cell.quantity.text = "\(chart.total.cleanValue)"
            
            cell.setChart(with: MarcketChart.chartArray[indexPath.row])
            

            cell.itemName.heroID = chart.name
            cell.price.heroID =  "price\(chart.name)"
            
            
            
            cell.delete.addTarget(self, action: #selector(self.delete(sender:)), for: .touchUpInside)
            cell.delete.tag = indexPath.row

            
            return cell
            
        }
      

    }
    
    
    
    func delete(sender: UIButton){
     
        //delete asset from marcket Chart
        self.totalPrice = totalPrice - MarcketChart.chartArray[sender.tag].price
        self.totalLabel.text = "£ \(totalPrice)"
        MarcketChart.chartArray.remove(at: sender.tag)
        tableView.reloadData();
        basketCount.text = "\(MarcketChart.chartArray.count)"

  
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           if (MarcketChart.chartArray[indexPath.row].modifiers.count == 0) {
    
            return 100
            
        }
           else {
            return 149
        }
    }
    
    
    @IBAction func CloseAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func repAction(_ sender: AnyObject) {
        transition.edge = .bottom
        transition.startingPoint = sender.center
        performSegue(withIdentifier: "settings", sender: self)
        
    }
    
    @IBAction func buyAction(_ sender: Any) {
        

        
        
        
        if (MarcketChart.chartArray.count == 0 ) {

            SCLAlertView().showError("Empty basket..", subTitle: "Select something before purchasing!!") // Error

        }
        else {

        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)

        alertView.addButton("No") {
            alertView.hideView()



            }

//Checkit
        alertView.addButton("Yes") {

            let size = CGSize(width: 90, height: 90)
            self.startAnimating(size, message: "Loading...", type: NVActivityIndicatorType(rawValue: 22)!)


            var assets : [[String : Any]] = []
            let header  = ["Authorization" : "Bearer \(self.token)"]
            for chart in MarcketChart.chartArray {

                print()
                if chart.isBulk == true {
                    var test : [String : Any] = [
                        
                        "name" : chart.name,
                        "address" : chart.path,
                        "issuer": chart.issuer,
                        "modifiers" : chart.modifiers,
                        "quantity" : (chart.total * chart.bulk).cleanValue
                        
                    ]
                    
                    assets.append(test)

                    
                }
                
                else {
                    var test : [String : Any] = [
                        
                        "name" : chart.name,
                        "address" : chart.path,
                        "issuer": chart.issuer,
                        "modifiers" : chart.modifiers,
                        "quantity" : chart.total.cleanValue
                        
                    ]
                    assets.append(test)

                    
                }
                
                

             

                print("chart adresse")
                print(chart.modifiers)


            }



            var purch : [String : Any] = [

                "address" : AppDelegate.currentUser!.address,
                "total" : String(format:"%.02f", self.totalPrice),
                "assets" : assets
            ]

            
            print("-----------------total price------------")
            print(self.totalPrice)
            
            


            AFWrapper.requestPOSTURL(Urls.PURCHASE, params: purch as! [String : AnyObject] , headers: header, success: { (JsonObject) in

                print(JsonObject)

                if JsonObject == "Success"{
                    MarcketChart.chartArray.removeAll()
                    self.tableView.reloadData()
                    self.totalPrice = 0.00
                    self.stopAnimating()
                    Utils.snackBar(message: "Success")
                    self.totalLabel.text = "£ 0.0"

                   
                    
                    
                    self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

                    
                    
                }
                else {
                    Utils.snackBar(message: "Something went wrong...")

                    self.stopAnimating()
                }


            }) { (JsonError) in

                print(JsonError)
                Utils.snackBar(message: "Something went wrong...")

                self.stopAnimating()


            }

        }



        alertView.showSuccess("£ \(totalPrice) to pay!", subTitle: "Are you sure you want to make this purchase?")




        }


    }
    
    
    
    
    func getMaskedCard(){
        
        //added wraper in alamofire 
        
        var purch : [String : Any] = [
            
            "address" : AppDelegate.currentUser!.address
        ]
        let header  = ["Authorization" : "Bearer \(self.token)"]

        print ("adresssse")
        print(AppDelegate.currentUser!.address)
        AFWrapper.requestPOSTURL(Urls.MASKED_CARD, params: purch as! [String : AnyObject], headers: header, success: { (JsonObject) in
            
            print("code is ")
            print(JsonObject)
            
            if(JsonObject == "Please add your card details before proceeding."){
                let appearanceNoCard = SCLAlertView.SCLAppearance(
                    showCloseButton: false
                )
                let alertViewNoCard = SCLAlertView(appearance: appearanceNoCard)
                
                alertViewNoCard.addButton("No") {
                    alertViewNoCard.hideView()
                    self.dismiss(animated: true, completion: nil)
                }
                
                
                alertViewNoCard.addButton("Yes") {
                    
                    MarcketChart.chartArray.removeAll()
                    
                    let scandCard  = UIStoryboard(name: "ScanCard", bundle: nil).instantiateViewController(withIdentifier: "CardViewController")
                    self.present(scandCard, animated: true, completion: nil)
                    
                }
                
                alertViewNoCard.showWarning("No credits card",subTitle:"Start by linking your credits card!")

                
            }
            else {
            
            self.cardLastNumbers.text = "...\( JsonObject["card_ending"].string!)"
            
            }
        }) { (JsonError) in
            
            print("error with masked card")
            print(JsonError)
            
            
          

            
        }
        
        
        
    }
    
  
    
    override func viewDidAppear(_ animated: Bool) {
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





