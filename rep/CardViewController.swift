//
//  CardViewController.swift
//  rep
//
//  Created by MacBook Pro on 04/09/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import KeychainSwift
import NVActivityIndicatorView
class CardViewController: UIViewController , CardIOPaymentViewControllerDelegate  , NVActivityIndicatorViewable {
    @IBOutlet weak var topView: UIView!
    let keychain = KeychainSwift()

    let card : Card = Card()
    @IBOutlet weak var txtCardNumber: CustomTextField!

    @IBOutlet weak var txtfullName: CustomTextField!
    @IBOutlet weak var txtCvc: CustomTextField!
    @IBOutlet weak var txtExpiry: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        topView.layer.cornerRadius = 10
        topView.clipsToBounds = true
    }
    @IBAction func done(_ sender: Any) {
        
        if (txtfullName.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            
            self.dismissKeyboard()
            
            Utils.snackBar(message: "Add your FullName please!")
        }else {
            if (txtCardNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ){
                self.dismissKeyboard()
                
                Utils.snackBar(message: "Add your card number please ! or Scan your card Again")
            }else {
                
                if (txtExpiry.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ){
                    self.dismissKeyboard()
                    
                    Utils.snackBar(message: "Add your expiry Data please ! or Scan your card Again")
                }else {
                    
                    
                    if (txtExpiry.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ){
                        self.dismissKeyboard()
                        
                        Utils.snackBar(message: "Add your CVC Number please ! or Scan your card Again")
                    }else {
                        
                        
                        print("card +++++++++ \(self.card.redactedCardNumber)")
                        /********************** Web Service ***********************/
                        //self.keychain.set(JSONResponse["address"].string!
                        let param : [String : String] = ["address": self.keychain.get("wallet") ,
                                                         "fullName" : "\(txtfullName.text!.trimmingCharacters(in: .whitespacesAndNewlines))",
                            "cardNumber": "\(self.card.redactedCardNumber)",
                            "expiryMo": "\(self.card.expiryMonth)",
                            "expiryYear" : "\(self.card.expiryYear)",
                            "cvc" : "\(self.card.cvv)"] as! [String : String]
                        
                        let token  =  self.keychain.get("token") as! String
                        
                        let header  = ["Authorization" : "Bearer \(token)"]
                        
                        print("********* CARDS params : \(param) ")
                        print("********* CARDS  Header: \(header) ")
                        
                        print(param)
                        print(header)
                        
                        let size = CGSize(width: 50, height: 50)
                        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType(rawValue: 29)!)

                        AFWrapper.requestPOSTURL(Urls.SAVE_CARD, params: param  , headers: [:], success: { (JsonObject) in
                            
                            
 

                            
                            
                            Utils.snackBar(message: "Thank you :D")
                            
                            self.stopAnimating()

                            self.dismiss(animated: true, completion: nil)

                            
                        }, failure: { (JsonError) in
                            
                            print("**********ERRRRO ********** CARD SAVED ******************************")
                            self.dismissKeyboard()
                            Utils.snackBar(message: "You have Already add your Card")
                                 self.stopAnimating()
                            print(JsonError)
                        })
                        
                        
                        
                        /**********************************************************/
                        
                        
                        
                        
                    }
                    
                }
                
            }

        }
        
        
        
       
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("test message")
    }
    
    @IBAction func startScanCardAction(_ sender: Any) {
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC?.modalPresentationStyle = .formSheet
        present(cardIOVC!, animated: true, completion: nil)
    }
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        //resultLabel.text = "user canceled"
        Utils.snackBar(message: "User Cancled")
        paymentViewController?.dismiss(animated: true, completion: nil)
    }
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            
            print("********START*************** CARD SAVED ******************************")

            
            let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
            //resultLabel.text = str as String
            card.cvv = info.cvv!
            card.expiryYear = "\(info.expiryYear)"
            card.expiryMonth =  "\(info.expiryMonth)"
            card.redactedCardNumber = info.cardNumber!
            
            txtCvc.text = card.cvv
            txtExpiry.text = "\(card.expiryMonth) / \(card.expiryYear)"
            txtCardNumber.text = card.redactedCardNumber
            
            

         }
        paymentViewController?.dismiss(animated: true, completion: nil)
    }

  
 

    @IBAction func closeAction(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
