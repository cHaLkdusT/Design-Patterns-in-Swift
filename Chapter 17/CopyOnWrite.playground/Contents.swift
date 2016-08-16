//: Playground - noun: a place where people can play

import Foundation

class Owner: NSObject, NSCopying {
    var name: String
    var city: String
    
    init(name: String, city: String) {
        self.name = name
        self.city = city
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        print("Copy")
        return Owner(name: self.name, city: self.city)
    }
}

class FlyweightFactory {
    class func createFlyweight() -> Flyweight {
        return Flyweight(owner: ownerSingleton)
    }
    
    private class var ownerSingleton: Owner {
        get {
            struct SingletonWrapper {
                static let singleton = Owner(name: "Anonymous", city: "Anywhere")
            }
            return SingletonWrapper.singleton
        }
    }
}

class Flyweight {
    private let extrinsicOwner: Owner
    private var intrincicOwner: Owner?
    
    init(owner: Owner) {
        self.extrinsicOwner = owner
    }
    
    var name: String {
        get {
            return intrincicOwner?.name ?? extrinsicOwner.name
        }
        set {
            decoupleFromExtrinsic()
            intrincicOwner?.name = newValue
        }
    }
    
    var city: String {
        get {
            return intrincicOwner?.city ?? extrinsicOwner.city
        }
        set {
            decoupleFromExtrinsic()
            intrincicOwner?.city = newValue
        }
    }
    
    private func decoupleFromExtrinsic() {
        if intrincicOwner == nil {
            intrincicOwner = extrinsicOwner.copyWithZone(nil) as? Owner
        }
    }
}