//
//  main.swift
//  Flyweight
//
//  Created by jlundang on 25/07/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//

let ss1 = Spreadsheet()
ss1.setValue(Coordinate(col: "A", row: 1), value: 100)
ss1.setValue(Coordinate(col: "A", row: 20), value: 200)
print("SS1 Total: \(ss1.total)")

let ss2 = Spreadsheet()
ss2.setValue(Coordinate(col: "F", row: 10), value: 200)
ss2.setValue(Coordinate(col: "G", row: 23), value: 250)
print("SS2 Total: \(ss2.total)")

print("Cells created: \(1300 + ss1.grid.count + ss2.grid.count)")