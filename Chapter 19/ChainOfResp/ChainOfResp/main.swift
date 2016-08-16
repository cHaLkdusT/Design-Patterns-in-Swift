//
//  main.swift
//  ChainOfResp
//
//  Created by jlundang on 08/08/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//

let messages:[Message] = [
    Message(from: "bob@example.com", to: "joe@example.com", subject: "Free for lunch?"),
    Message(from: "joe@example.com", to: "alice@acme.com", subject: "New Contracts"),
    Message(from: "pete@example.com", to: "all@example.com", subject: "Priority: All-hands Meeting")
]

let localT = LocalTransmitter()
let remoteT = RemoteTransmitter()
let priorityT = PriorityTransmitter()

if let chain = Transmitter.createChain(true) {
    for msg in messages {
        let handled = chain.sendMessage(msg)
        print("Message sent: \(handled)")
    }
}

//for msg in messages {
//    if msg.subject.hasPrefix("Priority") {
//        priorityT.sendMessage(msg)
//    } else if let index = msg.from.characters.indexOf("@") {
//        if msg.to.hasSuffix(msg.from[Range<String.Index>(start: index, end: msg.from.endIndex)]) {
//            localT.sendMessage(msg)
//        } else {
//            remoteT.sendMessage(msg)
//        }
//    } else {
//        print("Error: cannot send message to \(msg.from)")
//    }
//}