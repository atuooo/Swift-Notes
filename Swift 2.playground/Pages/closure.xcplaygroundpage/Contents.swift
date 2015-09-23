/*: 
## Closure
The Swift Programming Language(2.0): [cn](http://wiki.jikexueyuan.com/project/swift/chapter2/07_Closures.html) | [en](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94)
*/
import Foundation
//: Closure Expressions
// 闭包函数
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}
var reversed = names.sort(backwards)

// closure expression syntax
reversed = names.sort( {
                (s1: String, s2: String) -> Bool in
                    return s1 > s2 })

// Inferring Type From Context
reversed = names.sort( { s1, s2 in return s1 > s2 })

// Implicit return from Single-Expression closures
reversed = names.sort( { s1, s2 in s1 > s2 })

// Shorthand Argument Names
reversed = names.sort( { $0 > $1 } )

// Operator Functions
reversed = names.sort( > )

//: Trailing Closures
reversed = names.sort{
    (s1, s2) -> Bool in
    return s1 > s2
}

reversed = names.sort(){ $0 > $1 }
reversed = names.sort{ $0 > $1 }

// map(_:)
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [0, 16, 58, 510]

let strings = numbers.map {
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}

func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

/*: 
### Point-> Capturing Value
> **note:** 
　If you assign a closure to a property of a class instance, and the closure captures that instance by referring to the instance or its members, you will create a _strong reference cycle_ between the closure and the instance. Swift uses capture lists to break these strong reference cycles. For more information, see [Strong Reference Cycles for Closures](SRClosure).
*/
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()    // 10
incrementByTen()    // 20
let incrementByThree = makeIncrementer(forIncrement: 3)
incrementByThree()    // 3
incrementByTen()    // 30

 /// closures are Reference Type
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()    // 40

//: 当闭包被声明的时候，抓捕列表就复制一份thing变量，所以被捕捉的值并没有改变，即使你给thing赋了一个新值
var thing = "cars"

let closure = { [thing] in
    print("I love \(thing)")
}

thing = "airplanes"

closure()   // I love cars

//: [Back](@Home)
