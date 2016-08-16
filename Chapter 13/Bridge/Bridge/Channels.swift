//
//  Channels.swift
//  Bridge
//
//  Created by jlundang on 06/07/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

class Channel {
    enum Channels {
        case Landline
        case Wireless
        case Satellite
    }
    
    class func getChannel(channelType: Channels) -> Channel {
        switch channelType {
        case .Landline:
            return LandlineChannel()
        case .Wireless:
            return WirelessChannel()
        case .Satellite:
            return SatelliteChannel()
        }
    }
    
    func sendMessage(msg: Message) {
        fatalError("Not implemented")
    }
}

class LandlineChannel: Channel {
    override func sendMessage(msg: Message) {
        print("Landline: \(msg.contentToSend)")
    }
}

class WirelessChannel: Channel {
    override func sendMessage(msg: Message) {
        print("Wireless: \(msg.contentToSend)")
    }
}