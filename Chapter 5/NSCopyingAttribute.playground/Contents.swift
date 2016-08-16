import Foundation

class LogItem {
    var from: String?
    @NSCopying var data: NSArray?
}

var dataArray = NSMutableArray(array: [1, 2, 3, 4])

var logItem = LogItem()
logItem.from = "Alice"
logItem.data = dataArray

dataArray[1] = 10
print("Value \(logItem.data![1])")

/*:
 There are some limitations to the `@NSCopying` attribute. The first is that values set during initialization are not cloned, which is why we defined property of the `LogItem` class as optional so that we don't have to set values for them in an initializer.
 
 The other limitation is that the `@NSCopying` attribute will call the copy method, even when the object supports the `mutableCopy` method. This means that our `NSMUtableArray` object was converted into an immutable `NSArray` object when we assigned it to the data property of the `LogItem` method, preventing us from performing further modifications.
 */