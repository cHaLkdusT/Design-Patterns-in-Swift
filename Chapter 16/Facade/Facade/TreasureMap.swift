//
//  TreasureMap.swift
//  Facade
//
//  Created by jlundang on 21/07/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//

class TreasureMap {
    enum Treasures {
        case Galleon
        case BurriedGold
        case SunkenJewels
    }
    
    struct MapLocation {
        let gridLetter: Character
        let gridNumber: UInt
    }
    
    func findTreasure(type: Treasures) -> MapLocation {
        switch type {
            case .Galleon:
                return MapLocation(gridLetter: "D", gridNumber: 6)
            case .BurriedGold:
                return MapLocation(gridLetter: "C", gridNumber: 2)
            case .SunkenJewels:
                return MapLocation(gridLetter: "F", gridNumber: 12)
        }
    }
}