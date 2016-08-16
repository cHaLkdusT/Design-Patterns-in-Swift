//
//  Discounts.swift
//  Decorator
//
//  Created by jlundang on 12/07/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

class DiscountDecorator : Purchase {
    private let wrappedPurchase : Purchase
    
    init(purchase: Purchase) {
        self.wrappedPurchase = purchase
        super.init(product: purchase.description, price: purchase.totalPrice)
    }
    
    override var description: String {
        return super.description
    }
    
    var discountAmount: Float {
        return 0
    }
    
    func countDiscounts() -> Int {
        var total = 1
        if let discounter = wrappedPurchase as? DiscountDecorator {
            total += discounter.countDiscounts()
        }
        return total
    }
}

class BlackFridayDecorator : DiscountDecorator {
    override var totalPrice: Float {
        return super.totalPrice - discountAmount
    }
    
    override var discountAmount: Float {
        return super.totalPrice * 0.20
    }
}

class EndOfLineDecorator : DiscountDecorator {
    override var totalPrice: Float {
        return super.totalPrice - discountAmount
    }
    
    override var discountAmount: Float {
        return super.totalPrice * 0.70
    }
}