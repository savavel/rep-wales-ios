//
//  DisplayCardViewController.swift
//  rep
//
//  Created by Ahmed Chebbi on 28/10/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit

class DisplayCardViewController: UIViewController {
    var numTxtStr : String = ""
    @IBOutlet weak var numTxt: UILabel!
    var number : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        numTxt.text = "**** **** ****\(numTxtStr)"
        // Do any additional setup after loading the view.

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
    @IBAction func backAction(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func deleteAction(_ sender: Any) {
        
         let popOverVC = UIStoryboard(name: "ScanCard", bundle: nil).instantiateViewController(withIdentifier: "DeleteCardViewController") as! DeleteCardViewController
        popOverVC.number = self.number
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        popOverVC.displayCardViewController = self
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)

    }
}
