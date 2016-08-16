//class PriceCalculator {
//    class func calculatePrice(passengers:Int, days:Int) -> Float? {
//        let car = RentalCar.createRentalCar(passengers);
//        return car == nil ? nil : car!.pricePerDay * Float(days);
//    }
//}
class PriceCalculator {
    static func calculatePrice(passengers: Int, days: Int) -> Float? {
        let car = RentalCar.createRentalCar(passengers)
        return car == nil ? nil : car!.pricePerDay * Float(days)
    }
}