//
//  main.swift
//  Decorator
//
//  Created by jlundang on 12/07/2016.
//  Copyright © 2016 CHLKDST. All rights reserved.
//

let account = CustomerAccount(name: "Joe")

account.addPurchase(Purchase(product: "Red Hat", price: 10))
account.addPurchase(Purchase(product: "Scarf", price: 20))
//account.addPurchase(
//    EndOfLineDecorator(purchase:
//        BlackFridayDecorator(purchase:
//            PurchaseWithGiftWrap(purchase:
//                Purchase(product: "Sunglasses", price: 25)))))
account.addPurchase(
    EndOfLineDecorator(purchase:
        BlackFridayDecorator(purchase:
            GiftOptionDecorator(purchase:
                Purchase(product: "Sunglasses", price: 25), options: .Giftwrap, .Delivery))))


account.printAccount()


for p in account.purchases {
    if let d = p as? DiscountDecorator {
        print("\(p) has \(d.countDiscounts()) discounts")
    } else {
        print("\(p) has no discounts")
    }
}