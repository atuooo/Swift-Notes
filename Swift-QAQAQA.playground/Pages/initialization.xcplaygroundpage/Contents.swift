/*:
## 构造过程（Initialization）
The Swift Programming Language(2.0): [cn](http://wiki.jikexueyuan.com/project/swift/chapter2/14_Initialization.html#automatic_initializer_inheritance)
*/

import Foundation

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
        print("init")
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° F")

//: 构造参数
struct Celisius {
    var temperatureInCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celisius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celisius(fromKelvin: 273.15)

//: 参数的内部名称和外部名称
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

//: 不带外部名的构造器参数
extension Celisius {
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celisius(37.0)

//: 可选属性类型
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let chesseQuestion = SurveyQuestion(text: "Do you like cheese?")
chesseQuestion.ask()
chesseQuestion.response = "Yes, I do"

/*:
构造过程中常量属性的修改:

只要在构造过程结束前常量的值能确定，你可以在构造过程中的任意时间点修改常量属性的值。
对某个类实例来说，它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改。
*/

//: 默认构造器
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
item.quantity = 3

//: 结构体的逐一成员构造器
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 1.0, height: 2.0)

//: 值类型的构造器代理
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {   // 代理给 init(origin:size:)
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()  /// init() {}

let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
    size: Size(width: 3.0, height: 3.0))

//: 构造器的继承和重写
class Vehicle {         // Vehicle类只为存储型属性提供默认值，而不自定义构造器。因此，自动生成一个默认构造器
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheels"
    }
}

class Bicycle: Vehicle {
    override init() {   // 子类Bicycle定义了一个自定义指定构造器init()
        super.init()    // 确保Bicycle在修改属性之前它所继承的属性numberOfWheels能被Vehicle类初始化。
        numberOfWheels = 2
    }
}

//: 指定构造器和便利构造器操作
class Food {
    var name: String
    init(name: String) {    // Food类没有父类，所以init(name: String)构造器不需要调用super.init()来完成构造
        self.name = name
    }
    // 通过代理调用同一类中定义的指定构造器init(name: String)并给参数name传值[Unnamed]来实现
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    // 重写父类的指定构造器init(name: String)，必须在前面使用使用override标识
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

//class ShoppingListItem: RecipeIngredient {
//    var purchased = false
//    var description: String {
//        var output = "\(quantity) x \(name.lowercaseString)"
//        output += purchased ? " ✔" : " ✘"
//        return output
//    }
//}

//: 可失败构造器
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let anonymousCreature = Animal(species: "")
// anonymousCreature 的类型是 Animal?, 而不是 Animal

if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}

//: 枚举类型的可失败构造器
enum TemperatureUnitt {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

//: 带原始值的枚举类型的可失败构造器
// 带原始值的枚举类型会自带一个可失败构造器init?(rawValue:)
enum TemperatureUnit: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnit = TemperatureUnit(rawValue: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(rawValue: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

//: 类的可失败构造器
// 类的可失败构造器只能在所有的类属性被初始化后和所有类之间的构造器之间的代理调用发生完后触发失败行为。
class Product {
    let name: String!
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
}

if let bowTie = Product(name: "bow tie") {
    // 不需要检查 bowTie.name == nil
    print("The product's name is \(bowTie.name)")
}

//: 构造失败的传递
class CartItem: Product {
    var quantity: Int!
    init?(name: String, quantity: Int) {
        super.init(name: name)
        if quantity < 1 { return nil }
        self.quantity = quantity
    }
}

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}

//: 重写一个可失败构造器
class Document {
    var name: String?
    // 该构造器构建了一个name属性值为nil的document对象
    init() {}
    // 该构造器构建了一个name属性值为非空字符串的document对象
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

//: 必要构造器
class SomeClass {
    required init() {
        // 在这里添加该必要构造器的实现代码
    }
}

class SomeSubclass: SomeClass {
    required init() {   // 不需要加 override
        // 在这里添加子类必要构造器的实现代码
    }
}

//: 通过闭包和函数来设置属性的默认值
class ClosureClass {
    let someProperty: String = {
        var someValue = String()
        // 在这个闭包中给 someProperty 创建一个默认值
        // someValue 必须和 SomeType 类型相同
        return someValue
        }()
}

struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
        }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}

let board = Checkerboard()
print(board.squareIsBlackAtRow(row: 0, column: 1))
print(board.squareIsBlackAtRow(row: 9, column: 9))

//: [Back](@Home)
