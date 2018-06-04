//
//  EmptyChatViewController.swift
//  rep
//
//  Created by bechir kaddech on 11/7/17.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import Lottie

class EmptyChatViewController: UIViewController {
    
    
    @IBOutlet var emptyBasket: UIView!
    @IBOutlet weak var animationView: UIView!



    override func viewDidLoad() {
        super.viewDidLoad()


    
        //this for testing
        emptyBasket.frame = self.view.bounds
        emptyBasket.clipsToBounds = true
        self.view.addSubview(emptyBasket)
        
        
//        let animationViewAnim = LOTAnimationView.init(name: "atm_link")
//        animationViewAnim.frame = animationView.bounds
//        animationViewAnim.contentMode = .scaleAspectFill
//        animationViewAnim.loopAnimation = true
//        
//        animationView.addSubview(animationViewAnim)
//        
//        animationViewAnim.play()
        
    
    }

  
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
