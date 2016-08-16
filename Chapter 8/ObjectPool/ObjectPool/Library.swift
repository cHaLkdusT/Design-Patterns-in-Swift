import Foundation

final class Library {
//    private let books: [Book]
    private let pool: Pool<Book>
    
    private init(stockLevel: Int) {
        var stockId = 0
        stockId += 1
        pool = Pool<Book>(itemCount: stockLevel,
                          peakCount: stockLevel * 2,
                          returnCount: stockLevel / 2,
                          itemFactory: {
                            BookSeller.buyBook("Dicket, Charles",
                                title: "Hard Times",
                                stockNumber: stockId)
            },
                          peakFactory: { () in
                            return LibraryNetwork.borrowBook("Dickens, Charles",
                                title: "Hard Times",
                                stockNumber: stockId)
            },
                          reaper: LibraryNetwork.returnBook)
    
//        pool = Pool<Book>(maxItemCount: stockLevel, factory: {() in
//            Library.stockId = Library.stockId + 1
//            return BookSeller.buyBook("Dickens, Charles",
//                title: "Hard Times", stockNumber: Library.stockId)
//        })
        
//        var newBooks = [Book]()
//        for count in 1...stockLevel {
//            newBooks.append(Book(author: "Dickens, Charles",
//                title: "Hard Times", stock: count))
//        }
//        books = newBooks
//        pool = Pool<Book>(items: books)
    }
    
    private class var singleton: Library {
        struct SingletonWrapper {
            static let singleton = Library(stockLevel: 5)
        }
        return SingletonWrapper.singleton
    }
    
    class func checkoutBook(reader: String) -> Book? {
        let book = singleton.pool.getFromPool()
        book?.reader = reader
        book?.checkoutCount += 1
        return book
    }
    
    class func returnBook(book: Book) {
        book.reader = nil
        singleton.pool.returnToPool(book)
    }
    
    class func printReport() {
        singleton.pool.processPoolItems { (books) in
            for book in books {
                print("...Book#\(book.stockNumber)...")
                print("Check out \(book.checkoutCount) times")
                if (book.reader != nil) {
                    print("Checked out to \(book.reader)")
                } else {
                    print("In stock")
                }
            }
            print("There are \(books.count) books in the pool")
        }
        
    }
}