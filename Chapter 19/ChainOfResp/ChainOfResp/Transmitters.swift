//
//  Transmitters.swift
//  ChainOfResp
//
//  Created by jlundang on 08/08/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//

class Transmitter {
    var nextLink: Transmitter?
    
    required init() {}
    
    func sendMessage(message: Message, handled: Bool = false) -> Bool {
        if let nextLink = nextLink {
            return nextLink.sendMessage(message, handled: handled)
        } else if !handled {
            print("End of chain reached. Message not sent")
        }
        return handled
    }
    
    private class func matchEmailSuffix(message: Message) -> Bool {
        if let index = message.from.characters.indexOf("@") {
            return message.to.hasSuffix(message.from[Range<String.Index>(start: index, end: message.from.endIndex)])
        }
        return false
    }
    
    class func createChain(localOnly: Bool) -> Transmitter? {
        let transmitterClasses: [Transmitter.Type] = localOnly ?
            [PriorityTransmitter.self, LocalTransmitter.self] :
            [PriorityTransmitter.self, LocalTransmitter.self, RemoteTransmitter.self]
        
        var link: Transmitter?
        for tClass in transmitterClasses.reverse() {
            let existingLink = link
            link = tClass.init()
            link?.nextLink = existingLink
        }
        return link
    }
}

class LocalTransmitter: Transmitter {
    override func sendMessage(message: Message, var handled: Bool) -> Bool {
        if !handled && Transmitter.matchEmailSuffix(message) {
            print("Message to \(message.to) sent locally")
            handled = true
        }
        return super.sendMessage(message, handled: handled)
    }
}

class RemoteTransmitter: Transmitter {
    override func sendMessage(message: Message, var handled: Bool) -> Bool {
        if !handled && !Transmitter.matchEmailSuffix(message) {
            print("Message to \(message.to) sent remotely")
            handled = true
        }
        return super.sendMessage(message, handled: handled)
    }
}

class PriorityTransmitter: Transmitter {
    var totalMessages = 0
    var handledMessages = 0
    
    override func sendMessage(message: Message, var handled: Bool) -> Bool {
        totalMessages += 1
        if !handled && message.subject.hasPrefix("Priority") {
            handledMessages += 1
            print("Message to \(message.to) sent as priority")
            print("Stats: Handled \(handledMessages) of \(totalMessages)")
            handled = true
        }
        return super.sendMessage(message, handled: handled)
    }
}