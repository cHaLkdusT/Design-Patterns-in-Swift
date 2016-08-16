//
//  Booksources.swift
//  ObjectPool
//
//  Created by jlundang on 07/06/2016.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation

class BookSeller {
    class func buyBook(author: String, title: String, stockNumber: Int) -> Book {
        return Book(author: author, title: title, stock: stockNumber);
    }
}

class LibraryNetwork {
    class func borrowBook(author: String, title: String, stockNumber: Int) -> Book {
        return Book(author: author, title: title, stock: stockNumber)
    }
    
    class func returnBook(book: Book) {
        // do nothing
    }
}