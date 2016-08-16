//
//  Builder.swift
//  Builder
//
//  Created by jlundang on 29/06/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

import Foundation

enum Burgers {
    case Standard
    case BigBurger
    case SuperVeggie
}

class BurgerBuilder {
    private var veggie = false
    private var pickles = false
    private var mayo = true
    private var ketchup = true
    private var lettuce = true
    private var cooked = Burger.Cooked.Normal
    private var patties = 2
    private var bacon = true
    
    private init() {
        // do nothing
    }
    
    func setVeggie(choice: Bool) {
        self.veggie = choice
        if choice {
            bacon = false
        }
    }
    func setPickles(choice: Bool) { self.pickles = choice }
    func setMayo(choice: Bool) { self.mayo = choice }
    func setKetchup(choice: Bool) { self.ketchup = choice }
    func setLettuce(choice: Bool) { self.lettuce = choice }
    func setCooked(choice: Burger.Cooked) { self.cooked = choice }
    func addPatty(choice: Bool) { self.patties = choice ? 3 : 2 }
    func setBacon(choice: Bool) { self.bacon = choice }
    
    func buildObject(name: String) -> Burger {
        return Burger(name: name, veggie: veggie, patties: patties,
                      pickles: pickles, mayo: mayo, ketchup: ketchup,
                      lettuce: lettuce, cook: cooked, bacon: bacon)
    }
    
    class func getBuilder(burgerType: Burgers) -> BurgerBuilder {
        var builder: BurgerBuilder
        switch burgerType {
        case .BigBurger:
            builder = BigBurgerBuilder()
        case .SuperVeggie:
            builder = SuperVeggieBurgerBuilder()
        case .Standard:
            builder = BurgerBuilder()
        }
        return builder
    }
}

class BigBurgerBuilder: BurgerBuilder {
    private override init() {
        super.init()
        self.patties = 4
        self.bacon = false
    }
    
    override func addPatty(choice: Bool) {
        fatalError("Cannot add patty to Big Burger")
    }
}

class SuperVeggieBurgerBuilder: BurgerBuilder {
    private override init() {
        super.init()
        self.veggie = true
        self.bacon = false
    }
    
    override func setVeggie(choice: Bool) {
        // Do nothing = always veggie
    }
    
    override func setBacon(choice: Bool) {
        fatalError("Cannot add bacon to this burger")
    }
}