//
//  DetailView.swift
//  tut2
//
//  Created by brianchow on 1/11/2019.
//  Copyright © 2019 KooKi. All rights reserved.
//

import UIKit

class DetailView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var bookTitle = " "
    var bookAuthor = " "
    var bookPublisher = " "
    var bookIsbn = " "
    var bookImageUrl = " "
    var bookUrl = " "
    var publishDate = " "
    var numPage = " "
    
    //@IBOutlet var titleLabel: UILabel!
    //@IBOutlet var authorLabel: UILabel!
    //@IBOutlet var publisherLabel: UILabel!
    //@IBOutlet var isbnLabel: UILabel!
    //@IBOutlet var imageUrlLabel: UILabel!
    //@IBOutlet var bookUrlLabel: UILabel!
    //@IBOutlet var publishDateLabel: UILabel!
    //@IBOutlet var numPageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //titleLabel.text = bookTitle
        //authorLabel.text = bookAuthor
        //publisherLabel.text = bookPublisher
        //isbnLabel.text = bookIsbn
        //imageUrlLabel.text = bookImageUrl
        //bookUrlLabel.text = bookUrl
        //publishDateLabel.text = publishDate
        //numPageLabel.text = numPage
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
            cell.textLabel?.text = numPage
        }
        else if indexPath.section == 6 {
            cell.textLabel?.text = bookImageUrl
        }
        else if indexPath.section == 7 {
            cell.textLabel?.text = bookUrl
        }
        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
