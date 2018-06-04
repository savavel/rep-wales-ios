//
//  NetworkCnxViewContollerViewController.swift
//  tuniservice
//
//  Created by MacBook Pro on 13/08/2017.
//  Copyright © 2017 tuniservice. All rights reserved.
//

import UIKit
import Lottie
class NetworkCnxViewContoller: UIViewController {
   var lottieLogo: LOTAnimationView!
     @IBOutlet weak var vv: UIView!
     override func viewDidLoad() {
        super.viewDidLoad()

 
        
        let animationView = LOTAnimationView.init(name: "wifi_wiper")
        animationView.backgroundColor = UIColor.clear
        animationView.tintColor = UIColor.black
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        
        self.vv.addSubview(animationView)
        
        animationView.play()
        // Do any additional setup after loading the view.
        
        
        
        //Exit
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NetworkCnxViewContoller.closepopup(_:)))
        vv.isUserInteractionEnabled = true
        vv.addGestureRecognizer(tapGestureRecognizer)
     
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
      self.showAnimate()
        
    }
    /*********** Close Pop up when click hors view login ******/
    func closepopup(_ sender:AnyObject){
        
        self.removeAnimate()
        
    }
    /*********** END Close Pop up when click hors view login ******/
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}
