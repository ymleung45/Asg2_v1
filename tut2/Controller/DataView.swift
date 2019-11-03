//
//  DataView.swift
//  tut2
//
//  Created by brianchow on 1/11/2019.
//  Copyright © 2019 KooKi. All rights reserved.
//

import UIKit

// 0-isbn, 1-title, 2-author, 3-publisher, 4-publish date
// 5-num of page, 6-image url, 7-book url
var books = [
        ["isbn1", "title1", "author1", "publisher1", "publish date1", "num of page1", "image url1", "book url1"],
        ["isbn2", "title2", "author2", "publisher", "publish date", "num of page", "image url", "book url"],
        ["isbn3", "title3", "author3", "publisher", "publish date", "num of page", "image url", "book url"],
    ]

var bookIsbn = " "
var bookTitle = " "
var bookAuthor = " "
var bookPublisher = " "
var publishDate = " "
var numPage = " "
var bookImageUrl = " "
var bookUrl = " "

class DataView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    
    @IBOutlet var shelfTitleLabel: UILabel!
    @IBOutlet var shelfAuthorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as? BookTableViewCell else {
            return UITableViewCell()
        }
     
        let row = indexPath.row
        // cell.textLabel?.text = books[row][1] // 0-title
        // cell.foodImage.image = UIImage(named: food[indexPath.row].image)
        cell.bookImage.image = UIImage(named: "book\(row + 1)")
        cell.bookTitle.text = books[row][1]
        cell.bookAuthor.text = books[row][2]
        
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        print(books[row])
        bookIsbn = books[row][0]      // 0-isbn
        bookTitle = books[row][1]     // 1-title
        bookAuthor = books[row][2]    // 2-author
        bookPublisher = books[row][3] // 3-publisher
        publishDate = books[row][4]    // 4-publish date
        numPage = books[row][5]         // 5-num of page
        bookImageUrl = books[row][6]    // 6-image url
        bookUrl = books[row][7] // 7-book url
        
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let destinationVC = segue.destination as? DetailView {
                destinationVC.bookIsbn = bookIsbn
                destinationVC.bookTitle = bookTitle
                destinationVC.bookAuthor = bookAuthor
                destinationVC.bookPublisher = bookPublisher
                destinationVC.bookImageUrl = bookImageUrl
                destinationVC.bookUrl = bookUrl
                destinationVC.publishDate = publishDate
                destinationVC.numPage = numPage
            }
        }
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
