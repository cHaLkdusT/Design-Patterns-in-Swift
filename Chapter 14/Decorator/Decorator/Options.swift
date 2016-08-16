//
//  Options.swift
//  Decorator
//
//  Created by jlundang on 12/07/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

class BasePurchaseDecorator : Purchase {
    private let wrappedPurchase: Purchase
    
    init(purchase: Purchase) {
        wrappedPurchase = purchase
        super.init(product: purchase.description, price: purchase.totalPrice)
    }
}

class GiftOptionDecorator : Purchase {
    private let wrappedPurchase: Purchase
    private let options: [Option]
    
    enum Option {
        case Giftwrap
        case Ribbon
        case Delivery
    }
    
    init(purchase: Purchase, options: Option...) {
        self.wrappedPurchase = purchase
        self.options = options
        super.init(product: purchase.description, price: purchase.totalPrice)
    }
    
    override var description: String {
        var result = wrappedPurchase.description
        for option in options {
            switch option {
            case .Giftwrap:
                result = "\(result) + giftwrap"
            case .Ribbon:
                result = "\(result) + ribbon"
            case .Delivery:
                result = "\(result) + delivery"
            }
        }
        return result
    }
    
    override var totalPrice: Float {
        var result = wrappedPurchase.totalPrice
        for option in options {
            switch option {
            case .Giftwrap:
                result += 2
            case .Ribbon:
                result += 1
            case .Delivery:
                result += 5
            }
        }
        return result
    }
}

class PurchaseWithGiftWrap : BasePurchaseDecorator {
    override var description: String { return "\(super.description) + giftwrap" }
    override var totalPrice: Float { return super.totalPrice + 2 }
}

class PurchaseWithRibbon : BasePurchaseDecorator {
    override var description: String { return "\(super.description) + ribbon" }
    override var totalPrice: Float { return super.totalPrice + 1 }
}

class PurchaseWithDelivery : BasePurchaseDecorator {
    override var description: String { return "\(super.description) + delivery" }
    override var totalPrice: Float { return super.totalPrice + 5 }
}