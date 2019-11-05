//
//  UrlDetail.swift
//  tut2
//
//  Created by CHAN Cheuk Yin on 4/11/2019.
//  Copyright © 2019 KooKi. All rights reserved.
//

import UIKit
import WebKit

class UrlDetail: UIViewController {
    
    var link = ""

    @IBOutlet weak var urlView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Link: " + link)
        sendRequest(urlString: link )
        // Do any additional setup after loading the view.
    }
    
    
    
    
    private func sendRequest(urlString: String) {
        let myURL = URL(string: urlString)
        let myRequest = URLRequest(url: myURL!)
        urlView.load(myRequest)
    }
   

}
