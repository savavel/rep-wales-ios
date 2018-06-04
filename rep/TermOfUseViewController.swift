//
//  TermOfUseViewController.swift
//  rep
//
//  Created by bechir kaddech on 10/2/17.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class TermOfUseViewController: UIViewController,UIWebViewDelegate,NVActivityIndicatorViewable {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        webView.delegate = self
        webView.isHidden = true

     
        

        webView.loadRequest(URLRequest(url: URL(string: "https://rep.wales/terms/")!))

    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("did finish loading")
        webView.isHidden = false

    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        webView.isHidden = false

        
    }

    @IBAction func closeAction(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    

}
