//
//  IntroViewController.swift
//  rep
//
//  Created by bechir Kaddech on 8/30/17.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainSwift
import NVActivityIndicatorView


class   IntroViewController: UIViewController,NVActivityIndicatorViewable{
    
    
    let keychain = KeychainSwift()


    @IBOutlet weak var facebookBTN: UIButton!
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var emailBTN: UIButton!
 
    @IBOutlet weak var authView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    
    
    @IBOutlet var registerView: GradiantView!
    
    @IBOutlet var loginView: GradiantView!
    
    
    @IBOutlet weak var bottomView: UIView!
    
    
    
    //login UI
    
    @IBOutlet weak var usernameLogin: CustomTextField!
    @IBOutlet weak var passwordLogin: CustomTextField!
    
    
    //SignUp UI
    @IBOutlet weak var firstNameRegister: CustomTextField!
    @IBOutlet weak var lastNameRegister: CustomTextField!
    @IBOutlet weak var emailRegister: CustomTextField!
    @IBOutlet weak var passwordRegister: CustomTextField!
    
    
    
    override func viewDidLoad() {
        
        
        
        
        super.viewDidLoad()
        
         
        
        backBTN.isHidden = true
        authView.isHidden = true
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageView") as! PageViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.containerView.bounds
        self.containerView.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        

//        emailBTN.layer.shadowColor = UIColor.white.cgColor
//        emailBTN.layer.shadowRadius = 4.0
//        emailBTN.layer.shadowOpacity = 9
//        emailBTN.layer.shadowOffset = CGSize.zero
//        emailBTN.layer.masksToBounds = false
//        
//        
//        facebookBTN.layer.shadowColor = UIColor.white.cgColor
//        facebookBTN.layer.shadowRadius = 4.0
//        facebookBTN.layer.shadowOpacity = 9
//        facebookBTN.layer.shadowOffset = CGSize.zero
//        facebookBTN.layer.masksToBounds = false
        

    
    
    }
 
    override func viewDidAppear(_ animated: Bool) {
        
        
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
    
    @IBAction func EmailAction(_ sender: Any) {
    
        backBTN.isHidden = false
        containerView.isHidden = true
        authView.isHidden = false
        bottomView.isHidden = true
        
        
         registerView.frame = authView.bounds
       authView.addSubview(registerView)
   

        
    }
    
    @IBAction func BackAction(_ sender: Any) {
    
        backBTN.isHidden = true
        containerView.isHidden = false
        bottomView.isHidden = false

        authView.isHidden = true
      }


    @IBAction func GoToLoginAction(_ sender: Any) {
        registerView.removeFromSuperview()
        
        loginView.frame = authView.bounds
        authView.addSubview(loginView)
 
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        
        
        if (NetWork.isConnectedToNetwork() == true){
            
            if (usernameLogin.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
                  Utils.snackBar(message: "Please Enter your UserName")
            } else {
                if (passwordLogin.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
                    
                       Utils.snackBar(message: "Please Enter your Password")
                    
                }else {
                    
                    let size = CGSize(width: 90, height: 90)
                    self.startAnimating(size, message: "", type: NVActivityIndicatorType(rawValue: 16)!)
                    
                    AFWrapper.requestPOSTURL(Urls.USER_SIGNIN, params: ["email":usernameLogin.text!,"password":passwordLogin.text!], headers: nil, success: { (JSONResponse) in
                        
                        print("user logged in")
                        print(JSONResponse["token"].string!)
                        
                        
                    
                        
                        
                        
                        self.keychain.set(JSONResponse["token"].string!, forKey: "token")
                        self.keychain.set(self.usernameLogin.text!, forKey: "email")
                        self.keychain.set(self.passwordLogin.text!, forKey: "password")
                        
                        
                        let user : User = User()
                        user.token = JSONResponse["token"].string!
                        AppDelegate.getAllClients()
                        
                  
                        /******************* Set Token ADD WALLET **************/
                        
                        let headers = ["Content-Type":"application/json","Authorization":"bearer \(JSONResponse["token"].string!)"]
                        print("_____________ HEADERS : \(headers)")
                        print("****** USER INFO : \(Urls.USER_INFO)")
                        AFWrapper.requestGETwithParamsURL(Urls.USER_INFO, params: nil, headers: headers, success: {
                            (JSONResponse) -> Void in
                            print("*******YES*** END")
                            print(JSONResponse)
                            
                            self.keychain.set(JSONResponse["address"].string!, forKey: "wallet")
                            
                            
                            
                            
                            var params : [String : AnyObject] = [
                                
                                "address" : JSONResponse["address"].string! as AnyObject,
                                "token" : self.keychain.get("Token") as AnyObject
                            ]
                            
                            
                            AFWrapper.requestPOSTURL(Urls.DEVICE_TOKEN, params: params, headers: headers, success: { (JsonObject) in
                                
                                print("token was sent")
                                print(self.keychain.get("Token"))
                                
                            }, failure: { (Ereur) in
                                print("error")
                               
                            })
                       
                            
                            user.address = JSONResponse["address"].string!
                            user.name = JSONResponse["name"].string!
                            user.email = JSONResponse["email"].string!
                            user.lastname = JSONResponse["lastname"].string!
                            user.mnemonic = JSONResponse["mnemonic"].string!
                            user.type = JSONResponse["type"].string!

                            
                            AppDelegate.currentUser =  user
                            
                            self.stopAnimating()
                            
                            

                            let storyBoard: UIStoryboard = UIStoryboard(name: "Acceuil", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "nav")
                            newViewController.modalTransitionStyle = .crossDissolve
                            
                            
                            
                            
                            self.present(newViewController, animated: true, completion: nil)
                        }) {
                            (error) -> Void in
                               self.stopAnimating()
                            print(error)
                            print("*******ERREUR*** END")
                            
                            Utils.snackBar(message: "Erreur")
                            
                        }
                        print("*********** END")
                        /**************************************************/
                        
                        
                    }, failure: { (error) in
                           self.stopAnimating()
                        Utils.snackBar(message: "Something went wrong! check again")
                        
                    })
                    

                }
            }
            
        }else {
            print("****************** No Internet  Connection")
               self.stopAnimating()
            /*************** Check your Network **************/
            
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NetworkCnxViewContoller") as! NetworkCnxViewContoller
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
            /************** End Check your network *************/
        }
        
        
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        
        if (NetWork.isConnectedToNetwork() == true){
        
        
            if (firstNameRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
                self.dismissKeyboard()
                Utils.snackBar(message: "Please Enter your FirstName")

            } else {
                
                
                if (lastNameRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
                    self.dismissKeyboard()
                    Utils.snackBar(message: "Please Enter your LastName")
                    
                } else {
                    
                    
                    if (emailRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
                        self.dismissKeyboard()
                        Utils.snackBar(message: "Please Enter your Email")
                        
                    } else {
                        
                        if (Utils.isValidEmail(testStr: (emailRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines))!) == false){
                            self.dismissKeyboard()
                            Utils.snackBar(message: "Please Check your Email")

                            
                        } else {
                            
                            
                            
                            
                            /********************** Web Service *******************/
                            
                            let param  = ["firstname":firstNameRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                                "lastname":lastNameRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                                "email":emailRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                                "password":passwordRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                                "type":"user"]
                                AFWrapper.requestPOSTURL(Urls.USER_SIGNUP, params: param as! [String : String], headers: nil, success: { (JSONResponse) in
                            
                                
                                
                                print("**************** Res Register ********** \(JSONResponse)")
                                Utils.snackBar(message: "Welcome buddy")
                                
                                
                                
                                self.keychain.set((self.emailRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, forKey: "Email")
                                self.keychain.set((self.passwordLogin.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, forKey: "Password")
                                
                                
                                
                                
                                // Set Data To Login
                                
                                
                                self.usernameLogin.text = self.emailRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                                self.passwordLogin.text = self.passwordRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines)

                                
                                
                                self.registerView.removeFromSuperview()
                                
                                self.loginView.frame = self.authView.bounds
                                self.authView.addSubview(self.loginView)
                                
                                
                            }, failure: { (error) in
                                print(error)
                                Utils.snackBar(message: "Something went wrong! check again")
                            })
                            /*******************************************************/
                            
                            
                            
                            
                        }
                        
                    }
                    
                }
                
            }
        
        }else {
            print("****************** No Internet  Connection")
            /*************** Check your Network **************/
            
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NetworkCnxViewContoller") as! NetworkCnxViewContoller
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
            /************** End Check your network *************/
        }
        
        
    }
    

    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
