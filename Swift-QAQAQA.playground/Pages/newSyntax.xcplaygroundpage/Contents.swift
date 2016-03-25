/*:
## Some new Syntax
*/

import UIKit

//: do-while -> repeat-while
var i = 0
repeat {
    i += 1
    print(i)
} while i < 10

//: for-in + where
let numbers = [20, 18, 39, 49, 68, 230, 499, 238, 239, 723, 332]

for number in numbers where number > 100 {
    print(number)
}

//: switch 支持范围（range）与模式（pattern）匹配
let examResult = 49

switch examResult {
case 0...49: print("Fail!")
case 50...100: print("Pass!")
default: break
}

//: if case 范围匹配
if case 0...49 = examResult {       // 为什么这么写 enum ？
    print("Fail!")
} else if case 50...100 = examResult {
    print("Pass!")
}

//: if case 模式匹配
let userInfo = (id: "atuoOo", name: "atuoOo", age: 18, email: "aaatuooo@gmail.com")

if case (_, _, 0..<18, _) = userInfo {
    print("You're not allowed to register an account because you're below 18.")
} else if case (_, _, _, let email) = userInfo where email == "" {
    print("Your email is blank. Please fill in your email address.")
} else {
    print("You are good to go!")
}

/*:
guard:　一个 guard 陈述，就像 if 陈述一样，依照一个表达式的Bool值来执行陈述。为了让guard陈述后的程式被执行，你使用一个 guard 陈述来取得必须为真（true）的条件
*/
/// 隐身的可拆包的运算在代码的最后一行，因为dividend和divisor这两个参数已经被拆包并且以分别以一个常量来存储。
func divide(dividend: Double?, by divisor: Double?) -> Double? {
    guard let dividend = dividend else { return .None }
    guard let divisor = divisor else { return .None }
    guard divisor != 0 else { return .None }
    return dividend / divisor
}

func divideShort(dividend: Double?, by divisor: Double?) -> Double? {
    guard let dividend = dividend, divisor = divisor where divisor != 0 else { return .None }
    return dividend / divisor
}

struct Kitten {
}

func showKitten(kitten: Kitten?) {
    guard let k = kitten else {
        print("There is no kitten")
        fatalError()    /// @noreturn功能函数 fatalError( )
    }
    print(k)
}

//: for _ in (range)
for _ in 0...3 {
    print("hello")
}

//for index in stride(from: 1, through: 5, by: 2) {
//    print(index)
//}   // through是包括5

let dictionary = ["firstName": "Mango", "lastName": "Fang"]
for (key, value) in dictionary {
    print(key + " " + value)
}

//: Nil Coalescing Operator
var a: String?
var b = "b"
var c = a ?? b  // b
var d = (a != nil) ? a! : b // b  等价于 a ?? b

//: 采用相应的协议并且提供一个允许字面量初始化的公用方法
public struct Thermometer {
    public var temperature: Double
    public init(temperature: Double) {
        self.temperature = temperature
    }
}

extension Thermometer : FloatLiteralConvertible {
    public init(floatLiteral value: FloatLiteralType) {
        self.init(temperature: value)
    }
}

var t: Thermometer = Thermometer(temperature:56.8)
var thermometer: Thermometer = 56.8

//: 自定义运算符
// 运算符是^^,类型是infix（二进制），关联性是right，优先级设置成为155，原因是乘法和除法的优先级是150.
infix operator ^^ { associativity right precedence 155 }    // 如果操作产生的结果int不能代表，如大于int.max，就会发生运行时错误

func ^^(lhs: Int, rhs: Int) -> Int {
    let l = Double(lhs)
    let r = Double(rhs)
    let p = pow(l, r)
    return Int(p)
}

2^^3  // 8

//: ???
var draw: (CGContext)->() = { _ in () }

//: Swift 2.2 [☞](https://swift.org/blog/swift-2-2-released/) cn: [☞](http://swift.gg/2016/03/23/swift-22-new-features/)
/// SE-0001: Allow(most) keywords as argument labels:
// https://github.com/apple/swift-evolution/blob/master/proposals/0001-keywords-as-argument-labels.md

for i in 1.stride(to: 9, by: 2) {
    print(i)    // 1 3 5 7
}

func addParameter(name: String, `inout`: Bool) { }
var function : (String, `inout`: Bool) -> Void

/// SE-0011: Replace typealias keyword with associatedtype for associated type declarations
// https://github.com/apple/swift-evolution/blob/master/proposals/0011-replace-typealias-associated.md

protocol Prot {
    associatedtype Container : SequenceType
    
    // error: cannot declare type alias inside protocol, use protocol extension instead
    //    typealias Element = Container.Generator.Element
}

extension Prot {
    typealias Element = Container.Generator.Element
}

/// SE-0014: Constraining AnySequence.init
// https://github.com/apple/swift-evolution/blob/master/proposals/0014-constrained-AnySequence.md

/// SE-0015: Tuple comparison operators
// https://github.com/apple/swift-evolution/blob/master/proposals/0015-tuple-comparison-operators.md

let aTuple = ("I'm a", "tuple")
let bTuple = ("I'm b", "tuple")

if aTuple == bTuple {
    print("matching")
} else {
    print("non-matching")   // non
}

/// SE-0020: Swift Language Version Build Configuration
// https://github.com/apple/swift-evolution/blob/master/proposals/0020-if-swift-version.md

#if swift(>=2.2)
print("Running Swift 2.2 or later")
#else
    print("Running Swift 2.1 or earlier")
#endif

/// SE-0021: Naming Functions with Argument Labels
// https://github.com/apple/swift-evolution/blob/master/proposals/0021-generalized-naming.md

extension UIView {
    func insertSubview(view: UIView, at index: Int) { }
    func insertSubview(view: UIView, aboveSub siblingSubview: UIView) { }
    func insertSubview(view: UIView, belowSub siblingSubview: UIView) { }
}

UIView.insertSubview(_:at:)
UIView.insertSubview(_:aboveSub:)

//let button = UIButton(type:) // error: use of unresolved identifier 'UIButton(type:)'
let buttonFactory = UIButton.init(type:)   // 初始化的引用，不是初始化
buttonFactory(type: .Custom)

// error: ↓ type 'NSDictionary' has no member 'insertSubview(_:aboveSubview:)'
//let getter = Selector(NSDictionary.insertSubview(_:aboveSubview:))  // // produces insertSubview:aboveSubview:.

///SE-0022: Referencing the Objective-C selector of a method
// https://github.com/apple/swift-evolution/blob/master/proposals/0022-objc-selectors.md

let sel = #selector(UIView.insertSubview(_:atIndex:))

/// deprecate ++ & --
//for var i = 1; i <= 10; i += 1 { } // deprecates
for i in 1...10 { }
for i in (1...10).reverse() { }

/// deprecate tuple splat 
func foo(a: Int, b: Int) { }
foo(13, b: 25)

let x = (1, b: 2)
//foo(x)    // deprecate

/// deprecate var parameter
func sayHello(inout name: String, repeat repeatCount: Int) {
    name = name.uppercaseString
    for _ in 0 ..< repeatCount {
        print(name)
    }
}
var hello = "hello"
sayHello(&hello, repeat: 2)

/// add removeFirst()
var arr = Array(1...5)
arr.removeFirst()

var nilArr = Array(count: 0, repeatedValue: 0)
//nilArr.removeFirst() // error
//nilArr.removeLast()  // error
nilArr.popLast()       // nil

/// rename debug id: #line, #function, #file
print("This is on line \(__LINE__)") // old - deprecated
print("This is on line \(#line)")

//: [Back](Home)



