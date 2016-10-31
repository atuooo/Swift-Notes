/*:
## Swift Programming Paradigm
By [lincode](http://lincode.github.io/Swift-Paradigm/#rd?sukey=fc78a68049a14bb2884ece31cc642ba67f1b1197ac56c4a97abe2957c85f475dad628f6e58e50d00522a660fe03a8d64)
*/

import Foundation

var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
/*:
过程式编程：
- C

面向对象编程：
- Smalltalk
- Jave

函数式编程：
- Haskell
- Scheme
- Clojure
*/

/*:
#### 面向对象编程
- 核心观念：继承，多态，封装
- 单继承，多协议/扩展（弥补了没有多继承的局限，又避免了多继承难以控制的缺陷
- 更强大的结构体，枚举(不能继承或被继承): Array / Dictionary
- 更多的值类型：多用于数据封装、 引用类型用于封装有状态、能继承的对象
- 更安全(初始化、重写、optionals)：强类型语言＋静态类型语言(在编译期进行类型检查)
- 任何东西都成为对象并不是一件好事情：Java
*/

/*:
#### 函数式编程
- 主要思想：以函数为程序语言建模的核心 + 避免状态的可变性
- Swift中的函数都是一等函数，也都是高阶函数
- 闭包???：一个会对它内部引用的所有变量进行隐式绑定的函数。也可以说，闭包是由函数和与其相关的引用环境组合而成的实体。￼也可以说，函数实际上是一种特殊的闭包
- 不变性 ??? Haskell(找机会机会了解下)
- 惰性求值：表达式不在它被绑定到变量之后就立即求值，而是在该值被取用的时候求值(减少存储空间和计算量)
*/
/// 匿名闭包 in 分割参数和返回类型
let r = 1...3
let t = r.map { (i) -> Int in
    return i * 2
}

/// Swift 提供了一定程度的不变性支持
var mutable: String
let immutable = 1

/// 惰性求值：Swift默认是严格求值
let num = 1...3
let seq = num.map {
    (i: Int) -> Int in
    print("mapping \(i)")
    return i * 2
}

for i in seq {
    print(i)
}

/*:
#### 泛型编程
- 了解 [Generics](generics)
- 许多Swift标准库是通过泛型代码构建出来的
- 泛型为程序语言提供了更高层次的抽象
*/



//: [Back](Home)
