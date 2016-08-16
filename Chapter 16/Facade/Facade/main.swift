//
//  main.swift
//  Facade
//
//  Created by jlundang on 21/07/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//

import Foundation

/*
let map = TreasureMap()
let ship = PirateShip()
let crew = PirateCrew()

let treasureLocation = map.findTreasure(.Galleon)
// convert from map to ship coordinates
let sequence: [Character] = ["A", "B", "C", "D", "E", "F", "G"]
let eastWestPos = 4
let shipTarget = PirateShip.ShipLocation(NorthSouth:
    Int(treasureLocation.gridNumber), EastWest: eastWestPos)

// relocate ship
ship.moveToLocation(shipTarget) { location in
    // get the crew to work
    crew.performAction(.AttackShip) { prize in
        print("Prize: \(prize) pieces of eight")
    }
}

NSFileHandle.fileHandleWithStandardInput().availableData
*/

let facade = PirateFacade()
let prize = facade.getTreasure(.Ship)
if let prize = prize {
    facade.crew.performAction(.DiveForJewels) { secondPrize in
        print("Prize: \(prize + secondPrize) pieces of eight")
    }
//    print("Prize: \(prize) pieces of eight")
}
NSFileHandle.fileHandleWithStandardInput().availableData;