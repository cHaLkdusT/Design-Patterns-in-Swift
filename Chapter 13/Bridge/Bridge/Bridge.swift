//
//  Bridge.swift
//  Bridge
//
//  Created by jlundang on 11/07/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

class CommunicatorBridge {
    private var channel: Channel
    
    init(channel: Channel.Channels) {
        self.channel = Channel.getChannel(channel)
    }
    
    func send(message: String) {
        let msg = ClearMessage(message: message)
        sendMessage(msg)
    }
    
    func sendPriority(message: String) {
        sendMessage(PriorityMessage(message: message))
    }
    
    func sendEncryptedMessage(encryptedText: String) {
        let msg = EncryptedMessage(message: encryptedText)
        sendMessage(msg)
    }
    
    private func sendMessage(msg: Message) {
        msg.prepareMessage()
        channel.sendMessage(msg)
    }
}
