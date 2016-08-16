//
//  PirateCrew.swift
//  Facade
//
//  Created by jlundang on 21/07/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//

import Foundation

class PirateCrew {
    let workQueue = dispatch_queue_create("crewWorkQ", DISPATCH_QUEUE_SERIAL)
    
    enum Actions {
        case AttackShip
        case DigForGold
        case DiveForJewels
    }
    
    func performAction(action: Actions, callback: (Int) ->()) {
        dispatch_async(workQueue) { 
            var prizeValue = 0
            switch action {
            case .AttackShip:
                prizeValue = 10000
            case .DigForGold:
                prizeValue = 5000
            case .DiveForJewels:
                prizeValue = 1000
            }
            callback(prizeValue)
        }
    }
}