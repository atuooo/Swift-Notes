//:## Gists

import Foundation
import Darwin

/// 把一个负整数转换成一个无符号的整数
UInt(bitPattern: -3)

//: 计算数组中特殊值的个数
/// 在Swift 2.0 中，泛类型可以使用类型约束条件被强制扩展。但是假如这个泛类型不满足这个类型的约束条件，那么这个扩展方法既不可见也无法调用
extension Array where Element: Comparable { // 它使用了< 和==运算符，他们限制着T（占位类型）的实际类型，也就是说T必须遵循Comparable协议
    func countUniques() -> Int {
        let sorted = self.sorted(by: <)
        let initial: (Element?, Int) = (.none, 0)
        let reduced = sorted.reduce(initial) { ($1, $0.0 == $1 ? $0.1 : $0.1 + 1) }
        return reduced.1
    }
}

let array = [1, 1, 2, 3, 5, 5]
array.countUniques()    // return 4

//: 好像没什么特别的
enum MyError: Error {case Unlucky}

func myFailableFunction() throws -> String {
    let success = arc4random_uniform(5)
    if success == 0 { throw MyError.Unlucky}
    return "Success"
}

let result = (try myFailableFunction()) 
print(result)


//: 快速筛选
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

print( "toString(myvar0.dynamicType) -> \(type(of: myvar0))")
print( "toString(myvar1.dynamicType) -> \(type(of: myvar1))")
print( "toString(myvar2.dynamicType) -> \(type(of: myvar2))")
print( "toString(myvar3.dynamicType) -> \(type(of: myvar3))")

print( "toString(Int.self)           -> \(Int.self)")
print( "toString((Int?).self         -> \((Int?).self)")
print( "toString(NSString.self)      -> \(NSString.self)")
print( "toString(Array<String>.self) -> \(Array<String>.self)")

//print( "TypeName0 = \(_stdlib_getDemangledTypeName(myvar0))")
//print( "TypeName1 = \(_stdlib_getDemangledTypeName(myvar1))")
//print( "TypeName2 = \(_stdlib_getDemangledTypeName(myvar2))")
//print( "TypeName3 = \(_stdlib_getDemangledTypeName(myvar3))")

//: Array: Separate components By String
let keyString = "one two three four five"
let keys = keyString.components(separatedBy: " ")

//: [Back](Home)
