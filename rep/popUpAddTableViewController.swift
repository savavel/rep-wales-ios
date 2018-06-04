//
//  popUpAddTableViewController.swift
//  rep
//
//  Created by MacBook Pro on 07/10/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import KeychainSwift
import NVActivityIndicatorView
import SCLAlertView

class popUpAddTableViewController: UIViewController ,NVActivityIndicatorViewable{
    @IBOutlet weak var loadingView: NVActivityIndicatorView!

    let keychain = KeychainSwift()
    var slider : Int = 0
      @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnOrder: UIButton!
   // 
    
     @IBOutlet weak var viewG: UIView!
    @IBOutlet weak var txtNumberTable: CustomTextField!
    var optionsList = [String]()

    var feed : Feed? = nil

    @IBOutlet weak var viewBackground: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewG.layer.cornerRadius = 5        
        
        btnOrder.layer.cornerRadius = 5
        btnCall.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedClose(tapGestureRecognizer:)))
        viewBackground.isUserInteractionEnabled = true
        viewBackground.addGestureRecognizer(tapGestureRecognizer)
        
        self.showAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedClose(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.removeAnimate()
    }
    
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
        
    }
    @IBAction func doneAction(_ sender: Any) {
     
        
        
       // let data:[String: String] = ["text": (txtNumberTable.text?.trimmingCharacters(in: .whitespacesAndNewlines))!]
        let strTable : String = (txtNumberTable.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: data)
        if (strTable != ""){
            let wallet : String = self.keychain.get("wallet")!
            
            print("  count(tabMod) \(feed!.modifiers.count)")
            view.endEditing(true)

            
            
            let assets =  [
                "address" : feed!.asset,
                "quantity" : slider,
                "modifiers" : optionsList,
		"name" : feed!.name,
		"icon_url" : feed!.iconUrl,
		"issuer" : feed!.issuer
                ] as! [String : Any]
            
            
            
            var input = [
                "address": wallet,
                "assets" :  [assets],
                "table" : strTable
                ] as! [String : Any]
            
            
            /********************************/
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            
            //alertView.iconTintColor = UIColor(named: "#002F4C")
            alertView.addButton("No") {
                alertView.hideView()
                
                
                
            }
            alertView.addButton("Yes") {
                
                //let size = CGSize(width: 90, height: 90)
                //self.startAnimating(size, message: "Loading...", type: NVActivityIndicatorType(rawValue: 22)!)
                
                
                
                //  print(input)
                print(" ************************** INPUT ****************************** \(input)")
                self.loadingView.isHidden = false
                self.loadingView.startAnimating()
                AFWrapper.requestPOSTURL2(Urls.TABLE_ORDER, params: input as [String : AnyObject]  , headers: [:], success: { (ress) in
                    Utils.snackBarLong(message: "\(ress)")
                    self.loadingView.isHidden = true
                    self.loadingView.stopAnimating()
                    self.removeAnimate()
                    //self.dismiss(animated: true, completion: nil)
                }, failure: { (error) in
                    Utils.snackBarLong(message: "Check your network PLEASE!")
                    self.loadingView.isHidden = true
                    self.loadingView.stopAnimating()
                })
                
                self.loadingView.isHidden = true
                self.loadingView.stopAnimating()
            }
            
            alertView.showSuccess("Make order!", subTitle: "Are you sure you want to make this order?")
            
            
            /********************************/
            
            
            
            
            
            }else {
            Utils.snackBar(message: "Please enter number of table")
            loadingView.isHidden = true
            loadingView.stopAnimating()
            }
        
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        let data:[String: String] = ["text": ""]
        
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: data)
        self.removeAnimate()

    }
}

