//
//  main.swift
//  ReferenceCounting
//
//  Created by jlundang on 06/08/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//

import Foundation

let queue = dispatch_queue_create("requestQ", DISPATCH_QUEUE_CONCURRENT)

for count in 0 ..< 3 {
    let connection = NetworkConnectionFactory.createNetworkConnection()
    
    dispatch_async(queue) {
        connection.connect()
        connection.sendCommand("Command: \(count)")
        connection.disconnect()
    }
}

NSFileHandle.fileHandleWithStandardInput().availableData