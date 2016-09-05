/*:
## Strong Reference Cycle For Closure
The Swift Programming Language(2.0): [en](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID56) | [cn](http://wiki.jikexueyuan.com/project/swift/chapter2/16_Automatic_Reference_Counting.html#strong_reference_cycles_for_closures)
*/

import Foundation

class HTMLElement {
    
    let name: String
    let text: String?
    
    // 在默认的闭包中可以使用self，因为只有当初始化完成以及self确实存在后，才能访问 lazy 属性
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())

paragraph = nil /// ...... no deinit
//: ![closureReferenceCycle](closureReferenceCycle.png)

/*:
#### How to Resolve
Defining a Capture List
*/

//lazy var someClosure: (Int, String) -> String = {
//    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
//    // closure body goes here
//}

//lazy var otherClosure: Void -> String = {
//    [unowned self, weak delegate = self.delegate!] in
//    // closure body goes here
//}

/*:
#### Weak and Unowned References
在闭包和捕获的实例总是互相引用时并且总是同时销毁时，将闭包内的捕获定义为无主引用。

相反的，在被捕获的引用可能会变为nil时，将闭包内的捕获定义为弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil。这使我们可以在闭包体内检查它们是否存在

注意:
如果被捕获的引用绝对不会变为nil，应该用无主引用，而不是弱引用。
*/
class HTMLElementWithUnowned {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in                   // 用无主引用而不是强引用来捕获self
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}

var paragraph2: HTMLElementWithUnowned? = HTMLElementWithUnowned(name: "p", text: "hello, world")
print(paragraph2!.asHTML())

paragraph2 = nil    /// deinit here
//: ![closureReferenceCycle2](closureReferenceCycle2.png)

//: [Back](@Home)
