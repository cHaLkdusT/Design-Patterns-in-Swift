import Foundation

class Pool<T: AnyObject> {
    private var data = [T]()
    private let arrayQ = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_SERIAL)
    private let semaphore: dispatch_semaphore_t
    
    //    private var itemCount = 0
    //    private let maxItemCount: Int
    //    private let itemFactory: () -> T
    //    private var ejectedItems = 0
    //    private var poolExhausted = false
    
    private let itemFactory: () -> T
    private let peakFactory: () -> T
    private let peakReaper: (T) -> Void
    
    private var createdCount: Int = 0
    private let normalCount: Int
    private let peakCount: Int
    private let returnCount: Int
    private let waitTime: Int
    
    init(itemCount: Int, peakCount: Int, returnCount: Int, waitTime: Int = 2,
         itemFactory: () -> T, peakFactory: () -> T, reaper: (T) -> Void) {
        self.normalCount = itemCount
        self.peakCount = peakCount
        self.waitTime = waitTime
        self.returnCount = returnCount
        self.itemFactory = itemFactory
        self.peakFactory = peakFactory
        self.peakReaper = reaper
        self.semaphore = dispatch_semaphore_create(itemCount)
    }
    
//    init(maxItemCount: Int, factory: () -> T) {
//        self.itemFactory = factory
//        self.maxItemCount = maxItemCount
//        semaphore = dispatch_semaphore_create(maxItemCount)
//    }
    
//    init(items: [T]) {
//        data.reserveCapacity(data.count)
//        for item in items {
//            data.append(item)
//        }
//        semaphore = dispatch_semaphore_create(items.count)
//    }
    
    func getFromPool(maxWaitSeconds: Int = 5) -> T? {
        var result: T?
        
        let expiryTime = dispatch_time(DISPATCH_TIME_NOW,
                                       (Int64(waitTime) * Int64(NSEC_PER_SEC)))
        
        if (dispatch_semaphore_wait(semaphore, expiryTime) == 0) {
            dispatch_sync(arrayQ) {
                if self.data.count == 0 {
                    result = self.itemFactory()
                    self.createdCount += 1
                } else {
                    result = self.data.removeAtIndex(self.itemAllocator(self.data))
                }
            }
        } else {
            dispatch_sync(arrayQ) {
                result = self.peakFactory()
                self.createdCount += 1
            }
        }
//        let waitTime = (maxWaitSeconds == -1) ? DISPATCH_TIME_FOREVER :
//                dispatch_time(DISPATCH_TIME_NOW, (Int64(maxWaitSeconds) * Int64(NSEC_PER_SEC)))
//        
//        if !poolExhausted {
//            // Counter is decremented each time the `dispatch_semaphore_wait`
//            // function is called.
//            if dispatch_semaphore_wait(semaphore, waitTime) == 0 {
//                if !poolExhausted {
//                    dispatch_sync(arrayQ) {
//                        if (self.data.count == 0 && self.itemCount < self.maxItemCount) {
//                            result = self.itemFactory()
//                            self.itemCount += 1
//                        } else {
//                            result = self.data.removeAtIndex(0)
//                        }
//                    }
//                }
//            }
//
//        }
        return result
    }
    
    func returnToPool(item: T) {
        dispatch_async(arrayQ) {
            if self.data.count > self.returnCount &&
                self.createdCount > self.normalCount {
                self.peakReaper(item)
                self.createdCount -= 1
            } else {
                self.data.append(item)
                dispatch_semaphore_signal(self.semaphore)
            }
//            if let pitem = item as? PoolItem {
//                if pitem.canReuse {
//                    self.data.append(item)
//                    // Counter is incremented by calling the `dispatch_semaphore_signal`
//                    dispatch_semaphore_signal(self.semaphore)
//                } else {
//                    self.ejectedItems += 1
//                    if self.ejectedItems == self.maxItemCount {
//                        self.poolExhausted = true
//                        self.flushQueue();
//                    }
//                }
//            } else {
//                self.data.append(item)
//            }
        }
    }
    
    private func flushQueue() {
        let dQueue = dispatch_queue_create("drainer", DISPATCH_QUEUE_CONCURRENT)
        var backlogCleared = false
        
        dispatch_async(dQueue) { 
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER)
            backlogCleared = true
        }
        
        dispatch_async(dQueue) { 
            while !backlogCleared {
                dispatch_semaphore_signal(self.semaphore)
            }
        }
    }
    
    func processPoolItems(callback:[T] -> Void) {
        dispatch_barrier_sync(arrayQ) { 
            callback(self.data)
        }
    }
}