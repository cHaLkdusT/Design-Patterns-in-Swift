//
//  Commands.swift
//  Command
//
//  Created by jlundang on 10/08/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//

protocol Command {
    func execute()
}

class GenericCommand<T>: Command {
    private var receiver: T
    private var instructions: T -> Void
    
    init(receiver: T, instructions: T -> Void) {
        self.receiver = receiver
        self.instructions = instructions
    }
    
    func execute() {
         instructions(receiver)
    }
    
    class func createCommand(receiver: T, instructions: T -> Void) -> Command {
        return GenericCommand(receiver: receiver, instructions: instructions)
    }
}