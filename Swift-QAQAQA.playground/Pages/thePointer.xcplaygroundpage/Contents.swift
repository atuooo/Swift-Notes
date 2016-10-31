/*:
## Pointer in Swift
[-> swift pointer](http://onevcat.com/2015/01/swift-pointer/)　You can see some basic knowledge about the C Pointer in the CPointer.c in Sources folder      
[otherBlog](http://www.cocoachina.com/cms/wap.php?action=article&id=9900)
*/
import Foundation

//: ![](pointer.png)
func incrementorByMemory(ptr: UnsafeMutablePointer<Int>) {
    ptr.pointee += 1
}

var a = 10
incrementorByMemory(ptr: &a) // 11

/*:
　与这种做法类似的是使用 Swift 的 inout 关键字。我们在将变量传入 inout 参数的函数时，同样也使用 & 符号表示地址。不过区别是在函数体内部我们不需要处理指针类型，而是可以对参数直接进行操作。
*/
func incrementorByInout(num: inout Int) {
    num += 1
}

var b = 10
incrementorByInout(num: &b)  /// 虽然 & 在参数传递时表示的意义和 C 中一样，是某个“变量的地址”，但是在 Swift 中我们没有办法直接通过这个符号获取一个 UnsafePointer 的实例

var uInt: UInt = 33
func printPointer(_ pointer: UnsafeMutablePointer<UInt>) {
    print(pointer)
}
printPointer(&uInt)

/*:
指针初始化和内存管理

![](init.png)
*/

var intPtr = UnsafeMutablePointer<Int>.allocate(capacity: 1) /// 申请了 1 个 Int 大小的内存
intPtr.initialize(to: 10)   /// 初始化

///  手动释放指针指向的内容和指针本身
intPtr.deinitialize()
intPtr.deallocate(capacity: 1)

/**
其实在这里对于 Int 这样的在 C 中映射为 int 的 “平凡值” 来说，destroy 并不是必要的，因为这些值被分配在常量段上。但是对于像类的对象或者结构体实例来说，如果不保证初始化和摧毁配对的话，是会出现内存泄露的。所以没有特殊考虑的话，不论内存中到底是什么，保证 initialize: 和 destroy 配对会是一个好习惯
*/

//: 指向数组的指针
import Accelerate   /// C API

let aFloat: [Float] = [1, 2, 3, 4]
let bFloat: [Float] = [0.5, 0.25, 0.125, 0.0625]
var result: [Float] = [0, 0, 0, 0]

vDSP_vadd(aFloat, 1, bFloat, 1, &result, 1, 4)
result  /// 对于 const 参数，直接将 swift 数组传入；而对于可变数组，在前面加上 & 传入

//: 用 memory 直接操作数组
var array = [1, 2, 3, 4, 5]
var arrayPtr = UnsafeMutableBufferPointer<Int>(start: &array, count: array.count)
/// base Address 是第一个元素的指针
var basePtr = arrayPtr.baseAddress! as UnsafeMutablePointer<Int>

basePtr.pointee // 1
basePtr.pointee = 10
basePtr.pointee // 10

/// 下一个元素
var nextPtr = basePtr.successor()
nextPtr.pointee // 2

/*:
指针操作和转换

![](withPointer.png)
*/
var test = 10
test = withUnsafeMutablePointer(to: &test, { (ptr: UnsafeMutablePointer<Int>) -> Int in
    ptr.pointee += 1
    return ptr.pointee
})  /// ??? 这里其实我们做了和文章一开始的 incrementor 相同的事情，区别在于不需要通过方法的调用来将值转换为指针。这么做的好处对于那些只会执行一次的指针操作来说是显而易见的，可以将“我们就是想对这个指针做点事儿”这个意图表达得更加清晰明确

//: ![](bitCast.png)
let arr = NSArray(object: "meow")
let str = unsafeBitCast(CFArrayGetValueAtIndex(arr, 0), to: CFString.self) /// ？？？Core Foundation Sring
str // "meow"

//: ![](cAPI.png)
var count = 100
var voidPtr = withUnsafePointer(to: &count, { (a: UnsafePointer<Int>) -> UnsafeRawPointer in
    return unsafeBitCast(a, to: UnsafeRawPointer.self)
})  /// voidPtr 是 UnsafePointer<Void>。相当于 C 中的 void *

/// 转换回 UnsafePointer<Int>
var IntPtr = unsafeBitCast(voidPtr, to: UnsafePointer<Int>.self)
IntPtr.pointee //100

/*:
Conclusion:

![](conclusion.png)
*/

//: [Back](Home)
