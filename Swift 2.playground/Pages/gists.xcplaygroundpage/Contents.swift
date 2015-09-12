//:## Gists

import Foundation
import Darwin

/**
* 好像没什么特别的
*/
enum Error: ErrorType {case Unlucky}

func myFailableFunction() throws -> String {
    let success = arc4random_uniform(5)
    if success == 0 { throw Error.Unlucky}
    return "Success"
}

let result = (try myFailableFunction()) ?? "Unlucky"
print(result)

/**
* 快速筛选
*/
let oldArray = [1,2,3,4,5,6,7,8,9,10]
let newArray = oldArray.filter({$0 > 4}) // 函数式编程
newArray
//: [Back](Home)
