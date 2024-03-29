//
//  Book.swift
//  tut2
//
//  Created by KooKi Leung on 2/11/2019.
//  Copyright © 2019 KooKi. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class BookModel {
    var title: String
    var url: String
    var publishDate: String
    var numberOfPages: Int
    var publishers: String
    var authors: String
    var cover: String
    var isbn: String
    
    init(title: String, url: String, publishDate: String, numberOfPages: Int, publishers: String, authors: String, cover: String, isbn: String) {
        self.title = title
        self.url = url
        self.publishDate = publishDate
        self.numberOfPages = numberOfPages
        self.publishers = publishers
        self.authors = authors
        self.cover = cover
        self.isbn = isbn
    }
    
    
    func storebook() {
        print("storing book....")
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Book",
                                       in: managedContext)!
        
        let book = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        // 3
        book.setValue(self.title, forKeyPath: "title")
        book.setValue(self.url, forKeyPath: "url")
        book.setValue(self.publishDate, forKeyPath: "publishDate")
        book.setValue(self.numberOfPages, forKeyPath: "numberOfPages")
        book.setValue(self.publishers, forKeyPath: "publishers")
        book.setValue(self.authors, forKeyPath: "authors")
        book.setValue(self.cover, forKeyPath: "cover")
        book.setValue(self.isbn, forKeyPath: "isbn")
        
        let group = DispatchGroup()
        

        group.enter()
        if let imageurlString = URL(string: self.cover) {
            print("Download Started")
            
            geturlData(from: imageurlString) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? imageurlString.lastPathComponent)
                print("Download Finished")
                
                let imageData =  UIImage(data: data)?.pngData()
               
                book.setValue(imageData, forKeyPath: "coverimage")

                group.leave()
            }
        }else{
             group.leave()
        }
       


        group.wait()
        // 4
        do {
            try managedContext.save()
            //            managedContext.reset()
            print("save")
            //        people.append(book)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    
    func geturlData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    
}






