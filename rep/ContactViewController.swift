//
//  ContactViewController.swift
//  rep
//
//  Created by bechir kaddech on 10/2/17.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self
        webView.isHidden = true
        
        
        
        
        webView.loadRequest(URLRequest(url: URL(string: "https://rep.wales/contact/")!))

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
