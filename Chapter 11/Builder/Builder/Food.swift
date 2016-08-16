//
//  Food.swift
//  Builder
//
//  Created by jlundang on 27/06/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

import Foundation

class Burger {
    let customerName: String
    let veggieProduct: Bool
    let patties: Int
    let pickles: Bool
    let mayo: Bool
    let ketchup: Bool
    let lettuce: Bool
    let cook: Cooked
    let bacon: Bool
    
    enum Cooked: String {
        case Rare
        case Normal
        case WellDone = "Well Done"
    }
    
    init(name: String, veggie: Bool, patties: Int, pickles: Bool, mayo: Bool,
         ketchup: Bool, lettuce: Bool, cook: Cooked, bacon: Bool) {
        self.customerName = name
        self.veggieProduct = veggie
        self.patties = patties
        self.pickles = pickles
        self.mayo = mayo
        self.ketchup = ketchup
        self.lettuce = lettuce
        self.cook = cook
        self.bacon = bacon
    }
    
    func printDescription() {
        print("Name: \(customerName)")
        print("Veggie: \(veggieProduct)")
        print("Patties: \(patties)")
        print("Pickles: \(pickles)")
        print("Mayo: \(mayo)")
        print("Ketchup: \(ketchup)")
        print("Lettuce: \(lettuce)")
        print("Cook: \(cook)")
        print("Bacon: \(bacon)")
    }
}