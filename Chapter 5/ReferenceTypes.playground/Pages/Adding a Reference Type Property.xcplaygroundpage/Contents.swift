//: Playground - noun: a place where people can play

import Foundation

class Location {
    var name: String
    var address: String
    
    init(name: String, address: String) {
        self.name = name
        self.address = address
    }
}

class Appointment: NSObject, NSCopying {
    var name: String
    var day: String
    var place: Location
    
    init(name: String, day: String, place: Location) {
        self.name = name
        self.day = day
        self.place = place
    }
    
    func printDetails(label: String) {
        print("\(label) with \(name) on \(day) at \(place.address)")
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return Appointment(name: name, day: day, place: place)
    }
}

var beerMeeting = Appointment(name: "Bob", day: "Mon", place: Location(name: "Joe's Bar", address: "123 Main St"))

var workMeeting = beerMeeting.copy() as! Appointment
workMeeting.name = "Alice"
workMeeting.day = "Mon"
workMeeting.place.name = "Conference Rm 2"
workMeeting.place.address = "Company HQ"

beerMeeting.printDetails("Social")
workMeeting.printDetails("Work")
