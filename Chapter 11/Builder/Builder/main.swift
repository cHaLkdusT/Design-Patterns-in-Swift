//
//  main.swift
//  Builder
//
//  Created by jlundang on 27/06/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

import Foundation

// Step 1 - Ask for name
let name = "Joe"

// Step 2 - Select a Product
let builder = BurgerBuilder.getBuilder(.BigBurger)

// Step 3 - Customize burger?
builder.setMayo(false)
builder.setCooked(.WellDone)

let order = builder.buildObject(name)
order.printDescription()

//let builder = BurgerBuilder()
//
//// Step 1 - Ask for name
//let name = "Joe"
//
//// Step 2 - Is veggie meal required?
//builder.setVeggie(false)
//
//// Step 3 - Customize burger?
//builder.setMayo(false)
//builder.setCooked(.WellDone)
//
//// Step 4 - Buy additional patty?
//builder.addPatty(false)
//
//let order = builder.buildObject(name)
////let order = Burger(name: "Joe", veggie: false, patties: 2, pickles: true,
////                   mayo: true, ketchup: true, lettuce: true, cook: .Normal)
//order.printDescription()

