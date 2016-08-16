//
//  main.swift
//  Command
//
//  Created by jlundang on 10/08/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//

let calc = Calculator();
calc.add(10)
calc.multiply(4)
calc.subtract(2)
print("Total: \(calc.total)")

for _ in 0 ..< 3 {
    calc.undo()
    print("Undo called. Total: \(calc.total)")
}

print("Total: \(calc.total)")
//let snapshot = calc.getHistorySnapshot()
//print("Pre-Snapshot Total: \(calc.total)")
//snapshot?.execute()
//print("Post-Snapshot Total: \(calc.total)")