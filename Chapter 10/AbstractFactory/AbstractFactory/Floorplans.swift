protocol Floorplan {
    var seats: Int { get }
    var enginePosition: EngineOption { get }
}

enum EngineOption: String {
    case Front
    case Mid
}

class ShortFloorplan: Floorplan {
    let seats = 2
    let enginePosition = EngineOption.Mid
}

class StandardFloorplan: Floorplan {
    let seats = 4
    let enginePosition = EngineOption.Front
}

class LongFloorplan: Floorplan {
    let seats = 8
    let enginePosition = EngineOption.Front
    
}