//: [Previous](@previous)

import Foundation

let tq : Int? = 1
let b = tq.map { (a: Int) -> Int? in
    if a % 2 == 0 {
        return a
    } else {
        return nil
    }
}

print(b)

if let _ = b {
    print("not nil")
} else {
    print("nil")
}

//: [Next](@next)
