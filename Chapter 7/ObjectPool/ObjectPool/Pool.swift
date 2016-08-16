import Foundation

class Pool<T> {
    private var data = [T]()
    private let arrayQ = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_SERIAL)
    private let semaphore: dispatch_semaphore_t
    
    init(items: [T]) {
        data.reserveCapacity(data.count)
        for item in items {
            data.append(item)
        }
        semaphore = dispatch_semaphore_create(items.count)
    }
    
    func getFromPool() -> T? {
        var result: T?
        // Counter is decremented each time the `dispatch_semaphore_wait` 
        // function is called.
        if (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER) == 0) {
            dispatch_sync(arrayQ) {
                result = self.data.removeAtIndex(0)
            }
        }
        return result
    }
    
    func returnToPool(item: T) {
        dispatch_async(arrayQ) { 
            self.data.append(item)
            // Counter is incremented by calling the `dispatch_semaphore_signal`
            dispatch_semaphore_signal(self.semaphore)
        }
        
    }
}