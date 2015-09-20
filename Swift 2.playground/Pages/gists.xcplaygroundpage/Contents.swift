//:## Gists

import Foundation
import Darwin

/**
* 好像没什么特别的
*/
enum Error: ErrorType {case Unlucky}

func myFailableFunction() throws -> String {
    let success = arc4random_uniform(5)
    if success == 0 { throw Error.Unlucky}
    return "Success"
}

let result = (try myFailableFunction()) ?? "Unlucky"
print(result)

/**
* 快速筛选
*/
let oldArray = [1,2,3,4,5,6,7,8,9,10]
let newArray = oldArray.filter({$0 > 4}) // 函数式编程
newArray

//: print the type of the class or var
//var now = NSDate()
//var soon = now.dateByAddingTimeInterval(5.0)
//
//print("\(now.dynamicType.description())")
//print("\(now.dynamicType)")     /// "__NSDate"

class PureSwiftClass { }

var myvar0 = NSString() // Objective-C class
var myvar1 = PureSwiftClass()
var myvar2 = 42
var myvar3 = "Hans"

//var classname = reflect(myvar0).summary   // ???

print( "toString(myvar0.dynamicType) -> \(myvar0.dynamicType)")
print( "toString(myvar1.dynamicType) -> \(myvar1.dynamicType)")
print( "toString(myvar2.dynamicType) -> \(myvar2.dynamicType)")
print( "toString(myvar3.dynamicType) -> \(myvar3.dynamicType)")

print( "toString(Int.self)           -> \(Int.self)")
print( "toString((Int?).self         -> \((Int?).self)")
print( "toString(NSString.self)      -> \(NSString.self)")
print( "toString(Array<String>.self) -> \(Array<String>.self)")

print( "TypeName0 = \(_stdlib_getDemangledTypeName(myvar0))")
print( "TypeName1 = \(_stdlib_getDemangledTypeName(myvar1))")
print( "TypeName2 = \(_stdlib_getDemangledTypeName(myvar2))")
print( "TypeName3 = \(_stdlib_getDemangledTypeName(myvar3))")

//: Array: Separate components By String
let keyString : NSString = "one two three four five"
let keys : NSArray = keyString.componentsSeparatedByString(" ")

//: [Back](Home)
