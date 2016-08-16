//
//  main.swift
//  Bridge
//
//  Created by jlundang on 06/07/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

//var clearChannel = Landline()
//var secureChannel = SecureLandline()
//
//var comms = Communicator(clearChannel: clearChannel, secureChannel: secureChannel)
//
//comms.sendClearTextMessage("Hello!")
//comms.sendSecureMessage("This is a secret")

var bridge = CommunicatorBridge(channel: .Satellite)
//var comms = Communicator(clearChannel: bridge, secureChannel: bridge,
//    priorityChannel: bridge)
var comms = Communicator(channel: .Satellite)

comms.sendClearTextMessage("Hello!")
comms.sendSecureMessage("This is a secret")
comms.sendPriorityMessage("This is important")