import Foundation

var queue = dispatch_queue_create("workQ", DISPATCH_QUEUE_CONCURRENT)
var group = dispatch_group_create()

print("Starting...")

for i in 1...20 {
    dispatch_group_async(group, queue) {
        var book = Library.checkoutBook("reader#\(i)")
        if (book != nil) {
            NSThread.sleepForTimeInterval(Double(rand() % 2))
            Library.returnBook(book!)
        }
    }
}

dispatch_group_wait(group, DISPATCH_TIME_FOREVER)

print("All blocks complete")

Library.printReport()