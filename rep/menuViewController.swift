//
//  menuViewController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit
import SideMenu
import ElasticTransition
import KeychainSwift

 class menuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, ElasticMenuTransitionDelegate {

    @IBOutlet weak var tblTableView: UITableView!
    var contentLength:CGFloat = 320
    var token : String = ""
    let keychain = KeychainSwift()
    var dismissByBackgroundTouch = true
    var dismissByBackgroundDrag = true
    var dismissByForegroundDrag = true
    
    
    var lastSelectedIndex = IndexPath(row: 0, section: 0)
    var firstSelected : Bool = false


    var ManuNameArray:Array = [String]()
     override func viewDidLoad() {
        super.viewDidLoad()
        ManuNameArray = ["MANAGE CARDS","CHANGE PASSWORD","HISTORY","SUPPORT","CONTACT US","TERMS","PRIVACY","LOGOUT"]
   
        // Do any additional setup after loading the view.
        firstSelected = true

    }

    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManuNameArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
     //   cell.selectionStyle = .none

        
         cell.lblMenuname.text! = ManuNameArray[indexPath.row]
         return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let cell:MenuCell = tableView.cellForRow(at: indexPath) as! MenuCell
        // cell.backgroundMenuCell.backgroundColor = UIColor(hexString: "#BF2835")
         print(cell.lblMenuname.text!)
        if (cell.lblMenuname.text! == "PROMO CODES"){
            //Notification
            let Notification  = UIStoryboard(name: "Acceuil", bundle: nil).instantiateViewController(withIdentifier: "acceuil")
            self.show(Notification, sender: nil)
        }
        
        if (cell.lblMenuname.text! == "HISTORY"){
            //History
            let history  = UIStoryboard(name: "History", bundle: nil).instantiateViewController(withIdentifier: "ListHistoryWalletViewController") 
            //self.show(history, sender: nil)

            self.present(history, animated: true, completion: nil)

            
        }
      
        if (cell.lblMenuname.text! == "MANAGE CARDS"){
            //let scandCard  = UIStoryboard(name: "ScanCard", bundle: nil).instantiateViewController(withIdentifier: "CardViewController")
             //self.present(scandCard, animated: true, completion: nil)
            
            getMaskedCard()
        }
        
        if (cell.lblMenuname.text! == "TERMS"){
            let scandCard  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Terms")
            self.present(scandCard, animated: true, completion: nil)
        }
        
        if (cell.lblMenuname.text! == "CONTACT US"){
            let scandCard  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Contact")
            self.present(scandCard, animated: true, completion: nil)
        }
        
        
        if (cell.lblMenuname.text! == "CHANGE PASSWORD"){
           
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ChangePassword")
            newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
            
            
        }
        
        if (cell.lblMenuname.text! == "LOGOUT") {
            
            MarcketChart.chartArray.removeAll()
            
            let Main  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IntroView")
            var viewcontrollers = self.navigationController?.viewControllers
            viewcontrollers?.removeAll()
            self.show(Main, sender: nil)
            
            //
        }
      
        
        
  // dismiss(animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
         let cell:MenuCell = tableView.cellForRow(at: indexPath) as! MenuCell

        // cell.backgroundColor = MyColors.graySideMenu
        // cell.title.textColor = MyColors.dark]
      //   cell.backgroundMenuCell.backgroundColor = UIColor(hexString: "#D03547")
     }
    
    @IBAction func deconnexionAction(_ sender: Any) {
        
        
        
    }

}
extension menuViewController {

    // Manage Card
    func getMaskedCard(){
        
        //added wraper in alamofire
        token = self.keychain.get("token") as! String
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
                let scandCard  = UIStoryboard(name: "ScanCard", bundle: nil).instantiateViewController(withIdentifier: "CardViewController")
                self.present(scandCard, animated: true, completion: nil)
                
            }
            else {
                   var numberCode : String = JsonObject["card_ending"].string!
                let scandCard  = UIStoryboard(name: "ScanCard", bundle: nil).instantiateViewController(withIdentifier: "DisplayCardViewController") as! DisplayCardViewController
                scandCard.number = numberCode
                scandCard.numTxtStr = "\(JsonObject["card_ending"].string!)"
                self.present(scandCard, animated: true, completion: nil)
                // self.numTxt.text = "\(JsonObject["card_ending"].string!)"
                
            }
        }) { (JsonError) in
            
            print("error with masked card")
            print(JsonError)
            
            
            
            
            
        }
        
        
        
    }
}
