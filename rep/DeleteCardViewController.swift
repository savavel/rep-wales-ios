//
//  DeleteCardViewController.swift
//  rep
//
//  Created by Ahmed Chebbi on 29/10/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit

class DeleteCardViewController: UIViewController {
    @IBOutlet weak var viewMainRound: UIView!
    @IBOutlet weak var subViewMainRound: UIView!
    var displayCardViewController : DisplayCardViewController? = nil
    @IBOutlet weak var passwordTxt: CustomTextField!
    var number : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewMainRound.layer.cornerRadius = viewMainRound.frame.width/2
        subViewMainRound.layer.cornerRadius = subViewMainRound.frame.width/2
        self.showAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelAction(_ sender: Any) {
        self.removeAnimate()
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        if ((passwordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines))! == ""){
            Utils.snackBar(message: "Please entrer your 4 last degits !!")
        }else {
           
                
                let param : [String : String] = ["address" : AppDelegate.currentUser!.address ,
                                                 "password" : (passwordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines))!,
                                                 "number" : "\(number)"]
                print(param)
                AFWrapper.requestPOSTURL(Urls.DELETE_CARD, params: param, headers: [:], success: { (JSON) in
                    print("JSON : \(JSON)")
                    
                    Utils.snackBar(message: "\(JSON)")
                    self.removeAnimate()
                    self.displayCardViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

                }, failure: { (ERROR) in
                    print("ERROR : \(ERROR)")
                    Utils.snackBar(message: "Check your Network Or Data")
                })
                
        
        }
       
        
     
        

    }
    
    /** Animation **/
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
}
