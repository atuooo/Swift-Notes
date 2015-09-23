/*:
## Some new Syntax
*/

import UIKit

//: do-while -> repeat-while
var i = 0
repeat {
    i++
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

//: if ccase 模式匹配
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

for index in stride(from: 1, through: 5, by: 2) {
    print(index)
}   // through是包括5

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

//: [Back](Home)



