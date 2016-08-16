//
//  Orders.swift
//  Composite
//
//  Created by jlundang on 13/07/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

import Foundation

class CustomerOrder {
    let customer: String
    let parts: [CarPart]
    
    init(customer: String, parts: [CarPart]) {
        self.customer = customer
        self.parts = parts
    }
    
    var totalPrice: Float {
        return parts.reduce(0, combine: { (subtotal, part) -> Float in
            return subtotal + part.price
        })
    }
        
    func printDetails() {
        print("Order for \(customer): Cost: \(formatCurrencyString(totalPrice))")
    }
    
    func formatCurrencyString(number: Float) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(number) ?? ""
    }
}