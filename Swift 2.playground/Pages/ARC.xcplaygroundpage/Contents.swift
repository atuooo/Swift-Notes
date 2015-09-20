/*:
## ARC( Auto Reference Counting )
The Swift Programming Language(2.0): [cn](http://wiki.jikexueyuan.com/project/swift/chapter2/16_Automatic_Reference_Counting.html#strong_reference_cycles_for_closures) | [en](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID48)
*/

import Foundation

/*:
#### How ARC Works
note: 引用计数仅仅应用于类的实例。结构体和枚举类型是值类型，不是引用类型，也不是通过引用的方式存储和传递。
*/
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "Perl")   /// Perl is initialized here
reference2 = reference1
reference3 = reference2
reference3?.name    // Perl
reference1 = nil
reference2 = nil
reference3 = nil    /// Perl is deinitialized here

/*:
Strong Reference Cycles Between Class Instances
*/
class Apartment {
    let address: String
    init(address: String) { self.address = address }
    deinit { print("Apartment \(address) is deinitialized") }
}

class ApartmentA: Apartment {
    var tenant: PersonA?
}

class PersonA: Person {
    var apartment: ApartmentA?
}

var john: PersonA? = PersonA(name: "John")
var unit4A: ApartmentA? = ApartmentA(address: "unit4A")
john!.apartment = unit4A
unit4A!.tenant = john

john = nil      /// ......? why not deinit
unit4A = nil   /// ......? why not deinit
//:![referenceCycle](referenceCycle.png)

/*:
### How to Resolve Strong Reference Cycles
Swift 提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题：弱引用（weak reference）和无主引用（unowned reference）。
*/


/*:
#### weak reference
对于生命周期中会变为nil的实例使用弱引用。
*/
class PersonB: Person {
    weak var apartment: ApartmentB?     // weak: 弱引用必须被声明为变量，表明其值能在运行时被修改。弱引用不能被声明为常量。
}

class ApartmentB: Apartment {
    var tenant: PersonB?
}

var johnn: PersonB? = PersonB(name: "Johnn")
var unit4B: ApartmentB? = ApartmentB(address: "unit4B")
johnn!.apartment = unit4B
unit4B?.tenant = johnn

unit4B = nil    /// unit4B is deinitialized here
johnn = nil     /// Johnn is deinitialized here
//: ![weakReference](weakReference.png)

/*:
#### unowned reference
对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用。

注意:
如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。使用无主引用，你必须确保引用始终指向一个未销毁的实例。
还需要注意的是如果你试图访问实例已经被销毁的无主引用，Swift 确保程序会直接崩溃，而不会发生无法预期的行为。所以你应当避免这样的事情发生。
*/

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer      // unowned: 无主引用是永远有值的，无主引用总是被定义为非可选类型
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

var johh: Customer?

johh = Customer(name: "Johh Appleseed")
var card = CreditCard(number: 1234566, customer: johh!)
johh!.card = card //CreditCard(number: 1234_5678_9012_3456, customer: johh!)

johh = nil      /// johh & card is  deinitialized here
card.number
/// card.customer // error!
//:![unownedReference](unownedReference.png)

/*:
#### Unowned References and Implicitly Unwrapped Optional Properties
两个属性都必须有值，并且初始化完成后永远不会为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。
*/
class Country {
    let name: String
    var capitalCity: City!      // 将Country的capitalCity属性声明为隐式解析可选类型的属性
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country    // 使用无主属性
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

// 可以通过一条语句同时创建Country和City的实例，而不产生循环强引用，并且capitalCity的属性能被直接访问，而不需要通过感叹号来展开它的可选值
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")
country.capitalCity = nil

/// country = nil // error!

//: [Back](@Home)
