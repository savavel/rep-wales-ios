//
//  popUpQRCode.swift
//  rep
//
//  Created by MacBook Pro on 22/10/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import QRCode
import KeychainSwift
class popUpQRCode: UIViewController {
    let keychain = KeychainSwift()
    var feed : Feed? = nil
    var Quantity : Int = 0
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var viewG: UIView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewQRCode: UIView!
    var urlImage : String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewG.layer.cornerRadius = 5
        
 
        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedClose(tapGestureRecognizer:)))
        viewBackground.isUserInteractionEnabled = true
        viewBackground.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
            view1.layer.cornerRadius = view1.frame.width / 2
          img.layer.cornerRadius = img.frame.width/2
        if let url = URL.init(string: (urlImage!)) {
            img.af_setImage(withURL: url,imageTransition: .crossDissolve(0.5))
            img.contentMode = .scaleToFill
            
        }
        // Load QR Code
               let wallet : String = self.keychain.get("wallet")!
        
        //last 5 catacter
        let last4 = feed!.asset.substring(from:feed!.asset.index(feed!.asset.endIndex, offsetBy: -5))
                //Code QRCode
        
        var  strQuantity1 : String = ""
        if (Quantity < 10 ) {
            strQuantity1 = "00\(Quantity)"
        } else if (Quantity < 100){
            strQuantity1 = "0\(Quantity)"
        }else {
            strQuantity1 = "\(Quantity)"
        }
        
        var qrCodeStr : String = "\(strQuantity1)\(last4)\(feed!.code)"
        
        print("QRCODE STR : = \(qrCodeStr)")
        
        
               imgQRCode.image = {
                  var qrCode = QRCode("\(qrCodeStr)")!
                  qrCode.size = self.imgQRCode.bounds.size
                   qrCode.errorCorrection = .High
                 // qrCode.backgroundColor = UIColor(hexString: "#1D7CE3").ciColor
                  return qrCode.image
               }()
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
