//
//  NetworkRequest.swift
//  ReferenceCounting
//
//  Created by jlundang on 06/08/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//

import Foundation

protocol NetworkConnection {
    func connect()
    func disconnect()
    func sendCommand(command: String)
}

class NetworkConnectionFactory {
    class func createNetworkConnection() -> NetworkConnection {
        return connectionProxy
    }
    
    private class var connectionProxy: NetworkConnection {
        get {
            struct SingletonWrapper {
                static let singleton = NetworkConnectionProxy()
            }
            return SingletonWrapper.singleton
        }
    }
}

private class NetworkConnectionProxy: NetworkConnection {
    private let wrappedRequest: NetworkConnection
    private let queue = dispatch_queue_create("commandQ", DISPATCH_QUEUE_SERIAL)
    private var referenceCount = 0
    private var connected = false
    
    init() {
        wrappedRequest = NetworkConnectionImplementation()
    }
    
    func connect() {
        // Do nothing
    }
    
    private func disconnect() {
        // Do nothing
    }
    
    private func sendCommand(command: String) {
        self.referenceCount += 1
        dispatch_sync(queue) { 
            if !self.connected && self.referenceCount > 0 {
                self.wrappedRequest.connect()
                self.connected = true
            }
            self.wrappedRequest.sendCommand(command)
            self.referenceCount -= 1
            if self.connected && self.referenceCount == 0 {
                self.wrappedRequest.disconnect()
                self.connected = false
            }
        }
    }
}

private class NetworkConnectionImplementation: NetworkConnection {
    typealias me = NetworkConnectionImplementation
    
    func connect() {
        me.writeMessage("Connect")
    }
    
    func disconnect() {
        me.writeMessage("Disconnect")
    }
    
    func sendCommand(command: String) {
        me.writeMessage("Command: \(command)")
        NSThread.sleepForTimeInterval(1)
        me.writeMessage("Command completed: \(command)")
    }
    
    private class func writeMessage(msg: String) {
        dispatch_async(self.queue) { 
            print(msg)
        }
    }
    
    private class var queue: dispatch_queue_t {
        get {
            struct SingletonWrapper {
                static let singleton = dispatch_queue_create("writeQ",
                                                             DISPATCH_QUEUE_SERIAL)
            }
            return SingletonWrapper.singleton
        }
    }
}