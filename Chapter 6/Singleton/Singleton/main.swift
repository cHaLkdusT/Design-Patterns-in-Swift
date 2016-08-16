import Foundation

var server = BackupServer.server

let queue = dispatch_queue_create("workQueue", DISPATCH_QUEUE_CONCURRENT)
let group = dispatch_group_create()

for count in 0..<100 {
    dispatch_group_async(group, queue) {
        BackupServer.server.backup(DataItem(type: .Email, data: "bob@example.com"))
    }
}
dispatch_group_wait(group, DISPATCH_TIME_FOREVER)

print("\(server.getData().count) items were backed up")