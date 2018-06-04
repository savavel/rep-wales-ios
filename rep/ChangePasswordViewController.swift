//
//  ChangePasswordViewController.swift
//  rep
//
//  Created by bechir kaddech on 9/30/17.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import KeychainSwift

class ChangePasswordViewController: UIViewController,NVActivityIndicatorViewable {

    
    let keychain = KeychainSwift()
    var token : String = ""
    
    @IBOutlet weak var oldPassword: CustomTextField!
    
    @IBOutlet weak var newPassword: CustomTextField!
    
    @IBOutlet weak var confirmPassword: CustomTextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //token of current connected user
        token = self.keychain.get("token") as! String
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        let size = CGSize(width: 90, height: 90)
        self.startAnimating(size, message: "Updating Password...", type: NVActivityIndicatorType(rawValue: 22)!)
        updatePassword()
    }
    
    @IBOutlet weak var closeAction: UIButton!
    @IBAction func closePressed(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    func updatePassword() {
        
        
        
        if (oldPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" &&
            newPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" &&
            confirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            ){
            self.stopAnimating()

            Utils.snackBar(message: "Please Enter your UserName")
        }
        
        
        
        else {
            
            if(newPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == confirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)){
                
                
                var purch : [String : Any] = [
                    
                    "address" : AppDelegate.currentUser!.address,
                    "password" :oldPassword.text!,
                    "new_password" : newPassword.text!
                    
                ]
                let header  = ["Authorization" : "Bearer \(self.token)"]
                
                
                
                AFWrapper.requestPOSTURL(Urls.UPDATE_PASSWORD, params: purch as! [String : AnyObject], headers: header, success: { (JsonObject) in
                    
                    print("the result of the json objecyt")
                    print(JsonObject)
                    self.stopAnimating()
                    
                    MarcketChart.chartArray.removeAll()
                    
                    let Main  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IntroView")
                    var viewcontrollers = self.navigationController?.viewControllers
                    viewcontrollers?.removeAll()
                    self.show(Main, sender: nil)
                    
                }) { (JsonError) in
                    
                    print("something went wrong while updating password")
                    self.stopAnimating()
                    
                }
            }
            
            else {
                self.stopAnimating()

                Utils.snackBar(message: "Password dosen't match")
                
                
            }
            
        }
            }
        
    
 
    
}
