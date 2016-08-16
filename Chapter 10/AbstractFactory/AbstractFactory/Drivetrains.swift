protocol Drivetrain {
    var driveType: DriveOption { get }
}

enum DriveOption: String {
    case Front
    case Rear
    case All = "4WD"
}

class FrontWheelDrive: Drivetrain {
    let driveType = DriveOption.Front
}

class RearWheelDrive: Drivetrain {
    let driveType = DriveOption.Rear
}

class AllWheelDrive: Drivetrain {
    let driveType = DriveOption.All
}