//
//  webViewController.swift
//  IOSAsg1
//
//  Created by KooKi Leung on 11/10/2019.
//  Copyright © 2019 KooKi Leung. All rights reserved.
//

import UIKit
import WebKit
import CoreData



class WebView: UIViewController {
    
    var productCode = ""
    @IBOutlet weak var webViewKit: WKWebView!
    
    var sampleURL = "https://isbnsearch.org/isbn/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bookjson = BookJson()
        bookjson.getdata(id: "9780980200447")
        
        
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
    
    func readData(){
        print("readData")
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Book")
        
        //3
        do {
            var books = try managedContext.fetch(fetchRequest)
            for b in books{
                print(b.value(forKey: "title"))
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
}

