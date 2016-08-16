//: Playground - noun: a place where people can play

import Foundation

class Sum {
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
    
    init(first: Int, second: Int, cacheSize: Int) {
        resultsCached = Array(count: cacheSize, repeatedValue: Array(count: cacheSize, repeatedValue: 0))
        for i in 0..<cacheSize {
            for j in 0..<cacheSize {
                resultsCached[i][j] = i + j
            }
        }
        firstValue = first
        secondValue = second
    }
    
    var Result: Int {
        get {
            return firstValue < resultsCached.count && secondValue < resultsCached[firstValue].count ? resultsCached[firstValue][secondValue] : firstValue + secondValue
        }
    }
}

var calc1 = Sum(first: 0, second: 9).Result
var calc2 = Sum(first: 19, second: 8).Result

print("Calc1: \(calc1) Calc2: \(calc2)")

var calc3 = Sum(first: 0, second: 9, cacheSize: 100).Result
var calc4 = Sum(first: 3, second: 8, cacheSize: 20).Result