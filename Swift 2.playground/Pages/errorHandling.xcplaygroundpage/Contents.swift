/*:
## Error Handling
The Swift Programming Language(2.0): [cn](http://wiki.jikexueyuan.com/project/swift/chapter2/18_Error_Handling.html) | [en](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html#//apple_ref/doc/uid/TP40014097-CH42-ID508)
*/

import UIKit

//: 错误用符合 ErrorType 协议的值表示
enum VendingMachineError: ErrorType {
    case InvalidSelection
    case InsufficientFunds(required: Double)
    case OutOfStock
    case TestError
}

struct Item {
    var price: Double
    var count: Int
}

var inventory = [
    "Candy Bar": Item(price: 1.25, count: 7),
    "Chips": Item(price: 1.00, count: 4),
    "Pretzels": Item(price: 0.75, count: 11)
]
var amountDeposited = 1.00

//: throw 语句会马上改变程序流程
func vend(itemNamed name: String) throws {
    guard var item = inventory[name] else {
        throw VendingMachineError.InvalidSelection
    }
    
    guard item.count > 0 else {
        throw VendingMachineError.OutOfStock
    }
    
    if amountDeposited >= item.price {
        // Dispense the snack
        amountDeposited -= item.price
        --item.count
        inventory[name] = item
    } else {
        let amountRequired = item.price - amountDeposited
        throw VendingMachineError.InsufficientFunds(required: amountRequired)
    }
}

let favoriteSnacks = [
    "Alice":"Chips",
    "Bob":  "Licorice",
    "Eve":  "Pretzels"
]

var dic = Dictionary()
//: 当调用一个抛出函数时，在前面加上 try。后面的代码将不会执行
func buyFavoriteSnack(person: String) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vend(itemNamed: snackName)
}

/*:
 使用 do-catch 来捕获和处理错误

 　Swift中的错误处理和其他语言中的异常处理很像，使用了try、catch和throw关键字。不同的是，Swift不会展开调用堆栈，那会带来很大的性能损耗。因此，在Swift中throw语句的性能可以做到几乎和return语句一样
*/
do {
    try vend(itemNamed: "Candy Bar")
    print("Enjoy delicious snack")
} catch VendingMachineError.InvalidSelection {
    print("Invalid Selection")
} catch VendingMachineError.OutOfStock {
    print("Out of Stock.")
} catch VendingMachineError.InsufficientFunds(let   amountRequired) {
    print("Insufficient funds. Please insert an additional $\(amountRequired).")
}


/*:
禁止错误传播 ???

 　通过 `try!` 来调用抛出函数或方法禁止错误传送，并且把调用包装在运行时断言，这样就不会抛出错误。如果错误跑出了，会触发运行时错误
*/
//try buyFavoriteSnack("Bob")
/// 感觉这条语句会导致playground出现Bug：一直在Running
//try! buyFavoriteSnack("Alice")    

/*: 
 收尾操作

 　使用defer语句来在执行一系列的语句。这样不管有没有错误发生，都可以执行一些必要的收尾操作。包括关闭打开的文件描述符以及释放所有手动分配的内存。

 　defer语句把执行推迟到退出当前域的时候。defer语句包括defer关键字以及后面要执行的语句。被推迟的语句可能不包含任何将执行流程转移到外部的代码，比如break或者return语句，或者通过抛出一个错误。_被推迟的操作的执行的顺序和他们定义的顺序相反_，也就是说，在第一个defer语句中的代码在第二个defer语句中的代码之后执行
*/
func afterVend() throws {
    defer {
        print("close the vending machine")
    }
    
    do {
        try vend(itemNamed: "Candy Bar")
        print("Enjoy delicious snack")
    } catch VendingMachineError.InvalidSelection {
        print("Invalid Selection")
    } catch VendingMachineError.OutOfStock {
        print("Out of Stock.")
    } catch VendingMachineError.InsufficientFunds(let   amountRequired) {
        print("Insufficient funds. Please insert an additional $\(amountRequired).")
    }
    // closeTheMachine is called here, at the end of the scope
}

try afterVend()

//: [Back](Home)
