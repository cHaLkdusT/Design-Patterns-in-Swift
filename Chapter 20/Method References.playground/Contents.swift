//: Playground - noun: a place where people can play

class Printer {
    func printMessage(message: String, name: String) {
        print("\(message) name:\(name)")
    }
}

let printerObject = Printer()
printerObject.printMessage("Hello", name: "Julius")

Printer.printMessage(printerObject)("World", name: "Julius")