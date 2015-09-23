//: [Previous](@previous)

import Foundation

/// wrong: 原始值只能是字符串，字符，或者任何整型值或浮点型值 ？遵守Equatable协议 ?
//enum Edges : (Double, Double) {
//    case TopLeft = (0.0, 0.0)
//    case TopRight = (1.0, 0.0)
//    case BottomLeft = (0.0, 1.0)
//    case BottomRight = (1.0, 1.0)
//}

enum CompassPoint { // “不必给每一个枚举成员提供一个值”
    case North
    case South
    case East
    case West
}

let directionToHead = CompassPoint.South
switch directionToHead {
case .North:
    print("Lots of planets have a north")
case .South:
    print("Watch out for penguins")
case .East:
    print("Where the sun rises")
case .West:
    print("Where the skies are blue")
/// switch语句必须全面: 如果忽略了.West这种情况，上面那段代码将无法通过编译！可以添加 default 来涵盖未提出的成员
}

enum Barcode {
    case UPCA(Int, Int, Int)    // 这个定义不提供任何Int或String的实际值
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 85909_51226, 3)
productBarcode = .QRCode("ABCDEFGHIJKLMNOP")    /// 在任何指定时间只能存储其中之一

switch productBarcode {
case let .UPCA(numberSystem, identifier, check):
    print("UPC-A with value of \(numberSystem), \(identifier), \(check).")
case let .QRCode(productCode):
    print("QR code with value of \(productCode).")     // print QRcode
}

/// 枚举成员可以被默认值（称为原始值）预先填充，其中这些原始值具有相同的类型。
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

let tab = ASCIIControlCharacter.Tab.rawValue

let possibleCharacter = ASCIIControlCharacter(rawValue: "d")    /// 返回的是一个可选的枚举成员









//: [Back](@Home)
