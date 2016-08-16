//
//  Comms.swift
//  Bridge
//
//  Created by jlundang on 06/07/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

//protocol ClearMessageChannel {
//    func send(message: String)
//}
//
//protocol SecureMessageChannel {
//    func sendEncryptedMessage(encryptedText: String)
//}
//
//protocol PriorityMessageChannel {
//    func sendPriority(message: String)
//}

class Communicator {
//    private let clearChannel: ClearMessageChannel
//    private let secureChannel: SecureMessageChannel
//    private let priorityChannel: PriorityMessageChannel
//    
//    init(clearChannel: ClearMessageChannel, secureChannel: SecureMessageChannel,
//         priorityChannel: PriorityMessageChannel) {
//        self.clearChannel = clearChannel
//        self.secureChannel = secureChannel
//        self.priorityChannel = priorityChannel
//    }
//    
//    func sendClearTextMessage(message: String) {
//        self.clearChannel.send(message)
//    }
//    
//    func sendSecureMessage(message: String) {
//        self.secureChannel.sendEncryptedMessage(message)
//    }
//    
//    func sendPriorityMessage(message: String) {
//        self.priorityChannel.sendPriority(message)
//    }
    
    private let channel: Channel
    
    init(channel: Channel.Channels) {
        self.channel = Channel.getChannel(channel)
    }
    
    private func sendMessage(msg: Message) {
        msg.prepareMessage()
        channel.sendMessage(msg)
    }
    
    func sendClearTextMessage(message: String) {
        self.sendMessage(ClearMessage(message: message))
    }
    
    func sendSecureMessage(message: String) {
        self.sendMessage(EncryptedMessage(message: message))
    }
    
    func sendPriorityMessage(message: String) {
        self.sendMessage(PriorityMessage(message: message))
    }
}