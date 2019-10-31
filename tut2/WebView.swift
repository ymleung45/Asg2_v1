//
//  webViewController.swift
//  IOSAsg1
//
//  Created by KooKi Leung on 11/10/2019.
//  Copyright © 2019 KooKi Leung. All rights reserved.
//

import UIKit
import WebKit


class WebView: UIViewController {
    
    var productCode = ""
    @IBOutlet weak var webViewKit: WKWebView!
    
//    var sampleURL = "https://online-price-watch.consumer.org.hk/opw/product/"
     var sampleURL = "https://isbnsearch.org/isbn/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(productCode != ""){
            sampleURL = sampleURL + productCode
            print(sampleURL)
            sendRequest(urlString: sampleURL)
        }
        // Do any additional setup after loading the view.
    }
    private func sendRequest(urlString: String) {
      let myURL = URL(string: urlString)
      let myRequest = URLRequest(url: myURL!)
      webViewKit.load(myRequest)
    }

}
