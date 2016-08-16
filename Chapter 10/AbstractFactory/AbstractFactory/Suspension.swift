@objc protocol Suspension {
    var suspensionType: SuspensionOption { get }
    
    static func getInstance() -> Suspension
}

//enum SuspensionOption: String {
//    case Standard
//    case Sports = "Firm"
//    case Soft
//}

class RoadSuspension: Suspension {
    @objc let suspensionType = SuspensionOption.Standard
    
    private init() { }
    
    @objc class func getInstance() -> Suspension {
        return RoadSuspension()
    }
}

class OffRoadSuspension: Suspension {
    @objc let suspensionType = SuspensionOption.Soft
    
    private init() { }
    
    @objc class func getInstance() -> Suspension {
        return OffRoadSuspension()
    }
}

class RaceSuspension: NSObject, NSCopying, Suspension {
    let suspensionType: SuspensionOption = .Sports
    
    private override init() { }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return RaceSuspension()
    }
    
    class func getInstance() -> Suspension {
         return self.copy() as! Suspension
    }
}