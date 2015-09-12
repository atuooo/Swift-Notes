/*:
## Protocol Extension
/'protə'kɔl/ /ɪk'stɛnʃən/
　The Swift Programming Language(2.0): [cn](http://wiki.jikexueyuan.com/project/swift/chapter2/22_Protocols.html#protocol_extensions) |
*/

/*:
    Questions:
- 为什么用扩展，直接写在协议里不好么 ？
*/

import Foundation

var a = 10
/*:
使用扩展协议的方式可以为遵循者提供方法或属性的实现。通过这种方式，可以让你无需在每个遵循者中都实现一次，无需使用全局函数，你可以通过扩展协议的方式进行定义。
*/
// 你可以使用扩张加入新功能至 String
extension String {
    func contains(find: String) -> Bool {
        return self.rangeOfString(find) != nil
    }
}

var testString = "Hello Word"
testString.contains("Hello")

//: Instance
protocol Container {
    var items:[String] {get set}
    func numberOfItems() -> Int
    func randomItem() -> String     // 所有的类别都需要提供 此方法
}

class ToolBox: Container {
    var items:[String] = ["Glue Stick", "Scissors", "Hammer", "Level", "Screwdriver", "Jigsaw"]
}

class PaperBag: Container {
    var items:[String] = ["Bagel", "Baguette", "Black bread"]
}

class Basket: Container {
    var items:[String] = ["Orange", "Apple", "Honeydew", "Watermelon", "Pineapple"]
    var bonusItems:[String] = ["Blueberry", "Blackcurrant", "Durian"]
    
    func numberOfItems() -> Int {
        return items.count + bonusItems.count
    }
}

extension Container {
    func numberOfItems() -> Int {
        return items.count
    }
    
    // 在协议扩展中提供了 此方法，就不用再每一个类别中实现
    func randomItem() -> String {
//: ??? 为什么在库函数里找不到 arc4random_uniform() 　　　arc4random_addrandom()怎么用
        let randomIndex = Int(arc4random_uniform(UInt32(items.count)))
//        let randomIndex1 = Int(arc4random_addrandom(&a, UInt32(items.count)))
        return items[randomIndex]
    }
}

var container: Container = ToolBox()
container = Basket()
print("\(container.numberOfItems()) + \(container.randomItem())")

//: [Back](Home)
