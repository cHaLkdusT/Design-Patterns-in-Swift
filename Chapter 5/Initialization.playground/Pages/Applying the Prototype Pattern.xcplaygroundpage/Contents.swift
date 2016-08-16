//: Playground - noun: a place where people can play

import Foundation

class Sum: NSObject, NSCopying {
    var resultsCached: [[Int]]
    var firstValue: Int
    var secondValue: Int
    
    init(first: Int, second: Int) {
        resultsCached = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: 0))
        for i in 0..<10 {
            for j in 0..<10 {
                resultsCached[i][j] = i + j
            }
        }
        firstValue = first
        secondValue = second
    }
    
    private init(first: Int, second: Int, cache: [[Int]]) {
        firstValue = first
        secondValue = second
        resultsCached = cache
    }
    
    var Result: Int {
        get {
            return firstValue < resultsCached.count && secondValue < resultsCached[firstValue].count ? resultsCached[firstValue][secondValue] : firstValue + secondValue
        }
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return Sum(first: self.firstValue, second: self.secondValue, cache: self.resultsCached)
    }
}

var prototype = Sum(first: 0, second: 9)
var calc1 = prototype.Result
var clone = prototype.copy() as! Sum
clone.firstValue = 3
clone.secondValue = 8
var calc2 = clone.Result

print("Calc1: \(calc1) Calc2: \(calc2)")
