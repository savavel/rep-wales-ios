//
//  SplashViewController.swift
//  rep
//
//  Created by bechir Kaddech on 9/1/17.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import Lottie
import KeychainSwift


class SplashViewController: UIViewController {
    let keychain = KeychainSwift()

    
    @IBOutlet weak var lottieView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = LOTAnimationView(name: "snap_loader_white")
        animationView.frame = self.lottieView.bounds
        animationView.bounds = self.lottieView.bounds
        animationView.contentMode = .scaleAspectFill
        self.lottieView.addSubview(animationView)
        animationView.loopAnimation = true
        animationView.play()
        
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: "IntroView") as! IntroViewController
//            self.show(newViewController, sender: true)
//
//        })
        
        login();
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func login () {
        if (NetWork.isConnectedToNetwork() == true){
            
            var email : String
            
            var password : String
            
            
            
            if  let fpassword = keychain.get("password"), let femail = keychain.get("email") {
                password = fpassword
                email = femail
                
            }else {
                password = "test"
                email = "dummyData@test.com"
                
            }
            
            
            AFWrapper.requestPOSTURL(Urls.USER_SIGNIN, params: ["email":email,"password":password], headers: nil, success: { (JSONResponse) in
                        
                        self.keychain.set(JSONResponse["token"].string!, forKey: "token")
        
                        let user : User = User()
                        user.token = JSONResponse["token"].string!
                        AppDelegate.getAllClients()
                        
                        /******************* GET ADD WALLET **************/
                        
                        let headers = ["Content-Type":"application/json","Authorization":"bearer \(JSONResponse["token"].string!)"]
                        print("_____________ HEADERS : \(headers)")
                        print("****** USER INFO : \(Urls.USER_INFO)")
                        
                        
                        AFWrapper.requestGETwithParamsURL(Urls.USER_INFO, params: nil, headers: headers, success: {
                            (JSONResponse) -> Void in
                            print("*******YES*** END")
                            print(JSONResponse)
                            
                            self.keychain.set(JSONResponse["address"].string!, forKey: "wallet")
      
                            user.address = JSONResponse["address"].string!
                            user.name = JSONResponse["name"].string!
                            user.email = JSONResponse["email"].string!
                            user.lastname = JSONResponse["lastname"].string!
                            //user.mnemonic = JSONResponse["mnemonic"].string!
                            user.type = JSONResponse["type"].string!
                            
                            AppDelegate.currentUser =  user
                            
                            
                            
                            
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
                            
                            
                            
                            
                            
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Acceuil", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "nav")
                            newViewController.modalTransitionStyle = .crossDissolve
                         
                            self.present(newViewController, animated: true, completion: nil)
                        }) {
                            (error) -> Void in
                            print(error)
                            print("*******ERREUR*** END")
                            
                            Utils.snackBar(message: "Erreur")
                            
                        }
                        print("*********** END")
                        /**************************************************/
                        
                        
                    }, failure: { (error) in
                      
                      //  Utils.snackBar(message: "Something went wrong! check again")
                        
                        
                        
                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "IntroView") as! IntroViewController
                                    self.show(newViewController, sender: true)
                        
                    })
                    
                    
            
        
            
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
    
}
