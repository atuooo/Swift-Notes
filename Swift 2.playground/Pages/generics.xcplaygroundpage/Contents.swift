/*:
## Generics 
/dʒi'nerik/     The Swift Programming Language(2.0): [cn](http://wiki.jikexueyuan.com/project/swift/chapter2/23_Generics.html) | [en](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179)

　泛型代码可以让你写出根据自我需求定义、适用于任何类型的，灵活且可重用的函数和类型。它的可以让你避免重复的代码，用一种清晰和抽象的方式来表达代码的意图。
*/

import Foundation

//: Generic Functions
/// 你可以灵活地创建不同类型的数组或字典
// 只能交换 Int 类型
func swapTwoInts(inout a: Int, inout b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var aInt = 3    /// 只能定义为可变（var）类型
var bInt = 4
swapTwoInts(&aInt, b: &bInt)

// 使用泛型可以交换任意类型的数据
func swapTwoValue<T>(inout a a: T, inout _ b: T) { /// ??? T? why not C?
    let temporaryA = a
    a = b
    b = temporaryA
}

var aString = "I'm A"
var bString = "I'm B"
swapTwoValue(a: &aString, &bString) /// 定义时可以使用 _ 来省略第二个参数名 Or 在第一个参数名前加 a 来显示

/*:
Generic Types

![Generic Types](genericType.png)
*/
struct Stack<T> {
    var items = [T]()
    /// These methods are marked as mutating, because they need to modify (or mutate) the structure’s items array.
    mutating func push(item: T) {   // /'mjutet/
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("a")
stackOfStrings.push("b")
stackOfStrings.push("c")
print(stackOfStrings)   // a b c

let fromTheTop = stackOfStrings.pop()   // c

//: Extending a Generic Type
extension Stack {
    var topItem: T? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

let topItem = stackOfStrings.topItem    // b

/*:
Type Constraints

类型约束指定了一个必须继承自指定类的类型参数，或者遵循一个特定的协议或协议构成。
*/
/// 任何 T 类型都遵循 Equatable 协议
func findIndex<T: Equatable>(array array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(array: [3.14, 0.1, 0.25], 9.3) // nil
let stringIndex = findIndex(array: ["A", "B", "C"], "C")   // 2

/*:
Associated Types

![](associatedTypes.png)
*/
protocol Container {
    typealias ItemType  /// 关联类型: 不需要知道特定容器的类型就可以保留指定容器里的元素
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct StackWithTypealias<T>: Container {
    // original Stack<T> implementation
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    mutating func append(item: T) { /// Swift 可以推断出被用作这个特定容器的 ItemType 的 T 的合适类型
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> T {    /// 下角标
        return items[i]
    }
}

var stackOfInts = StackWithTypealias<Int>()
stackOfInts.push(1)
stackOfInts.push(2)
stackOfInts.push(3)

stackOfInts.append(4)
stackOfInts.items
stackOfInts.count
stackOfInts[2]

/*:
Extending an Existing Type to Specify an Associated Type
*/
extension Array: Container {
    
}

/*:
Where Clauses
*/
func allItemMatch<
    C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, _ anotherContainer: C2) {
        
        guard someContainer.count == anotherContainer.count else {
            print("The count of items is different.")
            return
        }
        
        for i in 0..<someContainer.count {
            guard someContainer[i] == anotherContainer[i] else {
                print("Not all items match")
                return
            }
        }
        
        print("All items match")
}

var stackOfString = StackWithTypealias<String>()
stackOfString.push("a")
stackOfString.push("b")
stackOfString.push("c")

var arrayOfString = ["a", "b", "c"] /// 上面声明了 Array 遵循 Container 协议

//: 即便栈和数组是不同的类型，但它们都遵循Container协议，而且它们都包含同样的类型值。因此可以调用allItemsMatch(_:_:)函数
allItemMatch(stackOfString, arrayOfString)

//: [back](Home)
