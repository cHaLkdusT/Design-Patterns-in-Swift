//
//  Facade.swift
//  Facade
//
//  Created by jlundang on 25/07/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//

import Foundation

enum TreasureTypes {
    case Ship
    case Buried
    case Sunken
}

class PirateFacade {
    let map = TreasureMap()
    let ship = PirateShip()
    let crew = PirateCrew()
    
    func getTreasure(type: TreasureTypes) -> Int? {
        var prizeAmount: Int?
        
        // select the treasure type
        var treasureMapType: TreasureMap.Treasures
        var crewWorkType: PirateCrew.Actions
        
        switch type {
        case .Ship:
            treasureMapType = .Galleon
            crewWorkType = .AttackShip
        case .Buried:
            treasureMapType = .BurriedGold
            crewWorkType = .DigForGold
        case .Sunken:
            treasureMapType = .SunkenJewels
            crewWorkType = .DiveForJewels
        }
        
        let treasureLocation = map.findTreasure(treasureMapType)
        
        // convert from map to ship coordinates
        let sequence: [Character] = ["A", "B", "C", "D", "E", "F", "G"]
        let eastWestPos = 4
        let shipTarget = PirateShip.ShipLocation(NorthSouth:
            Int(treasureLocation.gridNumber), EastWest: eastWestPos)
        
        let semaphore = dispatch_semaphore_create(0)
        
        // relocate ship
        ship.moveToLocation(shipTarget) { (location) in
            // get the crew to work
            self.crew.performAction(.AttackShip) { prize in
                prizeAmount = prize
                dispatch_semaphore_signal(semaphore)
            }
        }
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return prizeAmount
    }
}