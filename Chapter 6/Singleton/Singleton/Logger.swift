import Foundation

let globalLogger = Logger()

final class Logger {
    private var data = [String]()
    private let arrayQ = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_SERIAL)
    
    private init() {
        // Do nothing - required to stop instance being
        // created by code in other files
    }
    
    func log(msg: String) {
        dispatch_sync(arrayQ) { 
            self.data.append(msg)
        }
    }
    
    func printLog() {
        for msg in data {
            print("Log: \(msg)")
        }
    }
}