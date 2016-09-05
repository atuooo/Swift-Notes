/*: 
## Closure
The Swift Programming Language(2.0): [cn](http://wiki.jikexueyuan.com/project/swift/chapter2/07_Closures.html) | [en](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94)
*/
import Foundation
//: Closure Expressions
// 闭包函数
var names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}

//var reversed = names.sort(backwards)

// closure expression syntax
names.sort{ (s1, s2) -> Bool in
    return s1 > s2
}

// Inferring Type From Context
names.sort{ s1, s2 in return s1 > s2 }

// Implicit return from Single-Expression closures
names.sort{ s1, s2 in s1 > s2 }

// Shorthand Argument Names
names.sort{ $0 > $1 }

// Operator Functions
names.sort(by: >)


//: Trailing Closures
names.sort{
    (s1, s2) -> Bool in
    return s1 > s2
}

names.sort(){ $0 > $1 }
names.sort{ $0 > $1 }

/*: 
### Point-> Capturing Value
> If you assign a closure to a property of a class instance, and the closure captures that instance by referring to the instance or its members, you will create a _strong reference cycle_ between the closure and the instance. Swift uses capture lists to break these strong reference cycles. For more information, see [Strong Reference Cycles for Closures](SRClosure).
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

//: @autoclosure & ??
func printSth(_ toPrint: @autoclosure () -> String) {
    print(toPrint())
}

printSth("I'm auto closure")

Int("invalid-input") ?? 233 // ?? 👇

func ??<T>(optional: T?, defaultValue: @autoclosure () -> T) -> T {
    switch optional {
    case .some(let value):
        return value
    case .none:
        return defaultValue()
    }
}

Int("invalid-input") ?? 2333

//: [Back](@Home)
