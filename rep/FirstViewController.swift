//
//  FirstViewController.swift
//  rep
//
//  Created by bechir Kaddech on 8/30/17.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import Lottie

class FirstViewController: UIViewController {

    @IBOutlet weak var animation: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        


        
      
        
         let animationView = LOTAnimationView.init(name: "newAnimation")
            animationView.frame = animation.bounds
            animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
            
            animation.addSubview(animationView)
            
            animationView.play()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
