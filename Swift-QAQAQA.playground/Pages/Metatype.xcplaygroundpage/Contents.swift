//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: Difference Between "self, dynamicType, Type" [☞](http://stackoverflow.com/questions/35035185/swift-metatype-type-self)
class SomeClass {
    class func doSth() {
        print("I'm a class method. I belong to my type.")
    }
    
    func doSthOnlyIfInstanceOfThisType() {
        print("I'm as instance method. I belong to my type instance.")
    }
}

let cls: SomeClass.Type = SomeClass.self
cls.doSth()
//cls.doSthOnlyIfInstanceOfThisType()
/// cause compilation error, PRO TIP: actually you can take this method as a func property.

let cls2: SomeClass = SomeClass()
cls2.doSthOnlyIfInstanceOfThisType()
//cls2.doSth()
/// error: static member 'doSth' cannot be used on instance of type 'SomeClass'

/// PRO Tip:
let myFunc: ()->() = cls.doSthOnlyIfInstanceOfThisType(cls2)
myFunc

let cls3 = SomeClass.self   // .self a singleton instance representing the SomeClass Type.
cls3.doSth()

let cls4 = cls2.dynamicType
cls4.doSth()

class SomeBaseClass {
    class func printClassName() {
        print("SomeBaseClass")
    }
}
class SomeSubClass: SomeBaseClass {
    override class func printClassName() {
        print("SomeSubClass")
    }
}
let someInstance: SomeBaseClass = SomeSubClass()
/// someInstance 在编译期是 SomeBaseClass 类型，(怎么知道instance在编译时时的type）
/// 但是在运行期则是 SomeSubClass 类型
someInstance.dynamicType.printClassName()

if someInstance.dynamicType === SomeSubClass.self {
    print("The dynamic type of someInstance is SomeBaseCass")
} else {
    print("The dynamic type of someInstance isn't SomeBaseClass")
}
// 打印 “The dynamic type of someInstance isn't SomeBaseClass”

class AnotherSubClass: SomeBaseClass {
    let string: String
    required init(string: String) { ///
        self.string = string
    }
    override class func printClassName() {
        print("AnotherSubClass")
    }
    
    func printString() {
        print(string)
    }
}
let metatype: AnotherSubClass.Type = AnotherSubClass.self
let anotherInstance = metatype.init(string: "I'm metatype")

anotherInstance.printString()

//: http://swifter.tips/multi-method/

class Pet {}
class Cat: Pet {}
class Dog: Pet {}

func printPet(pet: Pet) {
    print("Pet")
}

func printPet(cat: Cat) {
    print("Meow")
}

func printPet(dog: Dog) {
    print("Bark")
}

printPet(Cat())
printPet(Dog())
printPet(Pet())

func printThem(pet: Pet, cat: Cat) {
    printPet(pet)
    printPet(cat)
}

printThem(Dog(), cat: Cat())

func printThemm(pet: Pet, cat: Cat) {
    if let aCat = pet as? Cat {
        printPet(aCat)
    } else if let aDog = pet as? Dog {
        printPet(aDog)
    }
    printPet(cat)
}

printThemm(Dog(), cat: Cat())

