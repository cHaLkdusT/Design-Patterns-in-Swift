//
//  Flyweight.swift
//  Flyweight
//
//  Created by jlundang on 25/07/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//

import Foundation

protocol Flyweight {
    subscript(index: Coordinate) -> Int? { get set }
    var total: Int { get }
    var count: Int { get }
}

extension Dictionary {
    init(setupFunc: () -> [(Key, Value)]) {
        self.init()
        for item in setupFunc() {
            self[item.0] = item.1
        }
    }
}

class FlyweightFactory {
    class func createFlyweight() -> Flyweight {
        return FlyweightImplementation(extrinsinc: extrinsicData)
    }
    
    private class var extrinsicData: [Coordinate: Cell] {
        get {
            struct SingletonWrapper {
                static let singletonData = Dictionary<Coordinate, Cell>(
                    setupFunc: {() in
                        var results = [(Coordinate, Cell)]()
                        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXZ"
                        var stringIndex = letters.startIndex
                        let rows = 50
                        repeat {
                            let colLetter = letters[stringIndex]
                            stringIndex = stringIndex.successor()
                            for rowIndex in 1...rows {
                                let cell = Cell(col: colLetter, row: rowIndex,
                                    val: rowIndex)
                                results.append((cell.coordinate, cell))
                            }
                        } while stringIndex != letters.endIndex
                        return results
                    }
                )
            }
            return SingletonWrapper.singletonData
        }
    }
}

class FlyweightImplementation: Flyweight {
    private let extrinsincData: [Coordinate: Cell]
    private var intrinsincData: [Coordinate: Cell]
    private let queue: dispatch_queue_t
    
    private init(extrinsinc: [Coordinate: Cell]) {
        self.extrinsincData = extrinsinc
        self.intrinsincData = [Coordinate: Cell]()
        self.queue = dispatch_queue_create("dataQ", DISPATCH_QUEUE_CONCURRENT)
    }
    
    subscript(key: Coordinate) -> Int? {
        get {
            var result: Int?
            dispatch_sync(self.queue) {
                if let cell = self.intrinsincData[key] {
                    result = cell.value
                } else {
                    result = self.extrinsincData[key]?.value
                }
            }
            return result
        }
        set {
            if let _ = newValue {
                dispatch_barrier_sync(self.queue) {
                    self.intrinsincData[key] = Cell(col: key.col,
                                           row: key.row,
                                           val: newValue!)
                }
            }
        }
    }
    
    var total: Int {
        var result = 0
        dispatch_sync(self.queue) {
            result = self.extrinsincData.values.reduce(0, combine: { (total, cell) in
                if let intrinsincCell = self.intrinsincData[cell.coordinate] {
                    return total + intrinsincCell.value
                } else {
                    return total + cell.value
                }
            })
        }
        return result
    }
    
    var count: Int {
        var result = 0
        dispatch_sync(self.queue) { 
            result = self.intrinsincData.count
        }
        return result
    }
}