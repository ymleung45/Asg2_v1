//
//  DataView.swift
//  tut2
//
//  Created by brianchow on 1/11/2019.
//  Copyright © 2019 KooKi. All rights reserved.
//

import UIKit
import CoreData

// 0-isbn, 1-title, 2-author, 3-publisher, 4-publish date
// 5-num of page, 6-image url, 7-book url
//var books = [
//        ["isbn1", "title1", "author1", "publisher1", "publish date1", "num of page1", "image url1", "book url1"],
//        ["isbn2", "title2", "author2", "publisher", "publish date", "num of page", "image url", "book url"],
//        ["isbn3", "title3", "author3", "publisher", "publish date", "num of page", "image url", "book url"],
//    ]




var bookIsbn = " "
var bookTitle = " "
var bookAuthor = " "
var bookPublisher = " "
var publishDate = " "
var numPage = " "
var bookImageUrl = " "
var bookUrl = " "

var currentBook: Book?

class DataView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    
    @IBOutlet var shelfTitleLabel: UILabel!
    @IBOutlet var shelfAuthorLabel: UILabel!
    
    var booksData:[Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readData()
//        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readData()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        print("Data viewWillAppear")
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
            booksData.removeAll()
            var books = try managedContext.fetch(fetchRequest) as! [Book]
            for b in books{
                booksData.append(b)
                //                print(b.title)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("book count: " + String(booksData.count))
        return booksData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as? BookTableViewCell else {
            return UITableViewCell()
        }
        
        let row = indexPath.row
        // cell.textLabel?.text = books[row][1] // 0-title
        // cell.foodImage.image = UIImage(named: food[indexPath.row].image)
        cell.bookImage.image = UIImage(named: "book\(row + 1)")
        cell.bookTitle.text = booksData[row].title
        cell.bookAuthor.text = booksData[row].authors
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        currentBook = booksData[row]
        print(booksData[row])
        bookIsbn = booksData[row].isbn ?? ""      // 0-isbn
        bookTitle = booksData[row].title ?? ""     // 1-title
        bookAuthor = booksData[row].authors ?? ""       // 2-author
        bookPublisher = booksData[row].publishers ?? ""    // 3-publisher
        publishDate = booksData[row].publishDate ?? ""      // 4-publish date
        numPage = String(booksData[row].numberOfPages) ?? ""            // 5-num of page
        bookImageUrl = booksData[row].cover ?? ""      // 6-image url
        bookUrl = booksData[row].url ?? ""    // 7-book url
        
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let destinationVC = segue.destination as? DetailView {
//                destinationVC.bookIsbn = bookIsbn
//                destinationVC.bookTitle = bookTitle
//                destinationVC.bookAuthor = bookAuthor
//                destinationVC.bookPublisher = bookPublisher
//                destinationVC.bookImageUrl = bookImageUrl
//                destinationVC.bookUrl = bookUrl
//                destinationVC.publishDate = publishDate
//                destinationVC.numPage = -1
                destinationVC.bookdata = currentBook
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
