//
//  DataView.swift
//  tut2
//
//  Created by brianchow on 1/11/2019.
//  Copyright © 2019 KooKi. All rights reserved.
//

import UIKit

// 0-title, 1-author, 2-publisher, 3-isbn, 4-image url, 5-book url
var books = [
        ["abc", "def", "ghi", "abc", "def", "ghi"],
        ["abc", "def", "ghi", "abc", "def", "ghi"],
        ["abc", "def", "ghi", "abc", "def", "ghi"],
    ]

var bookTitle = " "
var bookAuthor = " "
var bookPublisher = " "
var bookIsbn = " "
var bookImageUrl = " "
var bookUrl = " "

class DataView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
     
        let row = indexPath.row
        cell.textLabel?.text = books[row][0] // 0-title
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        print(books[row])
        bookTitle = books[row][0] // 0-title
        bookAuthor = books[row][1] // 1-author
        bookPublisher = books[row][2] // 2-publisher
        bookIsbn = books[row][3] // 3-isbn
        bookImageUrl = books[row][4]    // 4-image url
        bookUrl = books[row][5] // 5-book url
        
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let destinationVC = segue.destination as? DetailView {
                destinationVC.bookTitle = bookTitle
                destinationVC.bookAuthor = bookAuthor
                destinationVC.bookPublisher = bookPublisher
                destinationVC.bookIsbn = bookIsbn
                destinationVC.bookImageUrl = bookImageUrl
                destinationVC.bookUrl = bookUrl
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
