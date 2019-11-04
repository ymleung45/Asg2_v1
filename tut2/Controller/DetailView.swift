//
//  DetailView.swift
//  tut2
//
//  Created by brianchow on 1/11/2019.
//  Copyright © 2019 KooKi. All rights reserved.
//

import UIKit

class DetailView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var bookdata:Book?
    var bookDataModel:BookModel?
    
    
    
    var bookTitle = " "
    var bookAuthor = " "
    var bookPublisher = " "
    var bookIsbn = " "
    var bookImageUrl = " "
    var bookUrl = " "
    var publishDate = " "
    var numPage = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(bookdata != nil){
            bookTitle = bookdata?.title ?? ""
            bookAuthor = bookdata?.authors ?? ""
            bookPublisher = bookdata?.publishers ?? ""
            bookIsbn = bookdata?.isbn ?? ""
            bookImageUrl = bookdata?.cover ?? ""
            bookUrl = bookdata?.url ?? ""
            publishDate = bookdata?.publishDate ?? ""
            numPage = Int(bookdata?.numberOfPages ?? -1)
        }else{
            bookTitle = bookDataModel?.title ?? ""
            bookAuthor = bookDataModel?.authors ?? ""
            bookPublisher = bookDataModel?.publishers ?? ""
            bookIsbn = bookDataModel?.isbn ?? ""
            bookImageUrl = bookDataModel?.cover ?? ""
            bookUrl = bookDataModel?.url ?? ""
            publishDate = bookDataModel?.publishDate ?? ""
            numPage = Int(bookDataModel?.numberOfPages ?? -1)
        }

        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let button = UIButton(frame: CGRect(x: 5, y: 48, width: 100, height: 50))
        //        button.backgroundColor = .red
        button.setTitleColor(.red, for: .normal)
        button.setTitle("< Back", for: .normal)
        button.addTarget(self, action: #selector(buttonBack), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        let button2 = UIButton(frame: CGRect(x: screenSize.width-105, y: 48, width: 100, height: 50))
        //        button.backgroundColor = .red
        button2.setTitleColor(.red, for: .normal)
        button2.setTitle("Store", for: .normal)
        button2.addTarget(self, action: #selector(buttonStore), for: .touchUpInside)
        
        self.view.addSubview(button2)
        
    }
    
    @objc func buttonBack(sender: UIButton!) {
        print("back tapped")
        self.dismiss(animated: true)
    }
    
    @objc func buttonStore(sender: UIButton!) {
        print("store tapped")
        bookDataModel?.storebook()
        
    }
    
    @IBOutlet var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = bookIsbn
        }
        else if indexPath.section == 1 {
            cell.textLabel?.text = bookTitle
        }
        else if indexPath.section == 2 {
            cell.textLabel?.text = bookAuthor
        }
        else if indexPath.section == 3 {
            cell.textLabel?.text = bookPublisher
        }
        else if indexPath.section == 4 {
            cell.textLabel?.text = publishDate
        }
        else if indexPath.section == 5 {
            cell.textLabel?.text = String(numPage)
        }
        else if indexPath.section == 6 {
            cell.textLabel?.text = bookImageUrl
        }
        else if indexPath.section == 7 {
            cell.textLabel?.text = bookUrl
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String? {
        switch (section){
        case 0: return "ISBN"
        case 1: return "Title"
        case 2: return "Author"
        case 3: return "Publisher"
        case 4: return "Publish Date"
        case 5: return "Number of Page"
        case 6: return "Cover Image Url"
        case 7: return "Book Url"
        default: return nil
        }
    }
    
    
    
}
