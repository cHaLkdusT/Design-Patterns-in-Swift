//
//  Calculator.swift
//  Command
//
//  Created by jlundang on 10/08/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//
import Foundation

class Calculator {
    private(set) var total = 0
    private var history = [Command]()
    private var queue = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_SERIAL)
    private var performingUndo = false
    
    func add(amount: Int) {
        addUndoCommand(Calculator.add, amount: amount)
        total += amount
    }
    
    func subtract(amount: Int) {
        addUndoCommand(Calculator.subtract, amount: amount)
        total -= amount
    }
    
    func multiply(amount: Int) {
        addUndoCommand(Calculator.multiply, amount: amount)
        total *= amount
    }
    
    func divide(amount: Int) {
        addUndoCommand(Calculator.divide, amount: amount)
        total /= amount
    }
    
    private func addUndoCommand(method: Calculator -> Int -> Void, amount: Int)  {
        if !performingUndo {
            dispatch_sync(queue) {
                self.history.append(GenericCommand<Calculator>.createCommand(self,
                    instructions: { (calc) in
                        method(calc)(amount)
                }))
            }
        }
    }
    
    func undo() {
        dispatch_sync(queue) {
            if self.history.count > 0 {
                self.performingUndo = true
                self.history.removeLast().execute()
                self.performingUndo = false
            }
        }
    }
}