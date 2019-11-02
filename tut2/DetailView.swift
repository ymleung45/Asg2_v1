//
//  DetailView.swift
//  tut2
//
//  Created by brianchow on 1/11/2019.
//  Copyright © 2019 KooKi. All rights reserved.
//

import UIKit

class DetailView: UIViewController {
    
    var bookTitle = " "
    var bookAuthor = " "
    var bookPublisher = " "
    var bookIsbn = " "
    var bookImageUrl = " "
    var bookUrl = " "
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var publisherLabel: UILabel!
    @IBOutlet var isbnLabel: UILabel!
    @IBOutlet var imageUrlLabel: UILabel!
    @IBOutlet var bookUrlLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = bookTitle
        authorLabel.text = bookAuthor
        publisherLabel.text = bookPublisher
        isbnLabel.text = bookIsbn
        imageUrlLabel.text = bookImageUrl
        bookUrlLabel.text = bookUrl
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
