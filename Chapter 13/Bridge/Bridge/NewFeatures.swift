//
//  NewFeatures.swift
//  Bridge
//
//  Created by jlundang on 11/07/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

class SatelliteChannel : Channel {
    override func sendMessage(msg: Message) {
        print("Satellite: \(msg.contentToSend)")
    }
}

class PriorityMessage :ClearMessage {
    override var contentToSend: String {
        return "Important: \(super.contentToSend)"
    }
}
