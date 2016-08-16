class CarFactory {
    required init() {
        // Do nothing
    }
    
    func createFloorplan() -> Floorplan {
        fatalError("Not implemented")
    }
    
    func createSuspension() -> Suspension {
        fatalError("Not implemented")
    }
    
    func createDrivetrain() -> Drivetrain {
        fatalError("Not implemented")
    }
    
    final class func getFactory(car: Cars) -> CarFactory? {
        var factoryType: CarFactory.Type
        switch car {
        case .Compact:
            factoryType = CompactCarFactory.self
        case .Sports:
            factoryType = SportsCarFactory.self
        case .SUV:
            factoryType = SUVCarFactory.self
        }
        var factory = factoryType.sharedInstance
        if (factory == nil) {
            factory = factoryType.init()
        }
        return factory
    }
    
    class var sharedInstance: CarFactory? {
        get {
            return nil
        }
    }
//    final class func getFactory(car:Cars) -> CarFactory? {
//        var factoryType:CarFactory.Type;
//        switch (car) {
//        case .COMPACT:
//            factoryType = CompactCarFactory.self;
//        case .SPORTS:
//            factoryType = SportsCarFactory.self;
//        case .SUV:
//            factoryType = SUVCarFactory.self;
//        }
//        var factory = factoryType.sharedInstance;
//        if (factory == nil) {
//            factory = factoryType.init();
//        }
//        return factory;
//    }
//    
//    class var sharedInstance:CarFactory? {
//        get {
//            return nil;
//        }
//    }
}
