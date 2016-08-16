//
//  Purchase.swift
//  Decorator
//
//  Created by jlundang on 12/07/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

class Purchase : CustomStringConvertible {
    private let product: String
    private let price: Float
    
    init(product: String, price: Float) {
        self.product = product
        self.price = price
    }
    
    var description: String {
        return product
    }
    
    var totalPrice: Float {
        return price
    }
}
