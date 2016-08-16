//
//  Messages.swift
//  Bridge
//
//  Created by jlundang on 06/07/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

protocol Message {
    init(message: String)
    func prepareMessage()
    var contentToSend: String { get }
}

class ClearMessage: Message {
    private var message: String
    
    required init(message: String) {
        self.message = message
    }
    
    func prepareMessage() {
        // no action required
    }
    
    var contentToSend: String {
        return message
    }
}

class EncryptedMessage: Message {
    private var clearText: String
    private var cipherText: String?
    
    required init(message: String) {
        self.clearText = message
    }
    
    func prepareMessage() {
        cipherText = String("cipherText\(clearText)")
    }
    
    var contentToSend: String {
        return cipherText!
    }
}
