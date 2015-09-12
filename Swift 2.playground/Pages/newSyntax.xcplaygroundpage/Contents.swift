/*:
## Some new Syntax
*/

import UIKit

//: do-while -> repeat-while
var i = 0
repeat {
    i++
    print(i)
} while i < 10

//: for-in + where
let numbers = [20, 18, 39, 49, 68, 230, 499, 238, 239, 723, 332]

for number in numbers where number > 100 {
    print(number)
}

//: switch 支持范围（range）与模式（pattern）匹配
let examResult = 49

switch examResult {
case 0...49: print("Fail!")
case 50...100: print("Pass!")
default: break
}

//: if case 范围匹配
if case 0...49 = examResult {       // 为什么这么写 enum ？
    print("Fail!")
} else if case 50...100 = examResult {
    print("Pass!")
}

//: if ccase 模式匹配
let userInfo = (id: "atuoOo", name: "atuoOo", age: 18, email: "aaatuooo@gmail.com")

if case (_, _, 0..<18, _) = userInfo {
    print("You're not allowed to register an account because you're below 18.")
} else if case (_, _, _, let email) = userInfo where email == "" {
    print("Your email is blank. Please fill in your email address.")
} else {
    print("You are good to go!")
}

/*:
guard:　一个 guard 陈述，就像 if 陈述一样，依照一个表达式的Bool值来执行陈述。为了让guard陈述后的程式被执行，你使用一个 guard 陈述来取得必须为真（true）的条件
*/
struct Article {
    var title:String?
    var description:String?
    var author:String?
    var totalWords:Int?
}

func printInfo(article: Article) {
    guard let totalWords = article.totalWords where totalWords > 1000 else {
        print("Error: Couldn't print the total word count!")
        return
    }
    
    guard let title = article.title else {
        print("Error: Couldn't print the title of the article!")
        return
    }
    
    print("Title: \(title)")
}

let sampleArticle = Article(title: "Swift Guide", description: "A beginner's guide to Swift 2", author: "Simon Ng", totalWords: 900)
printInfo(sampleArticle)

//: for _ in (range)
for _ in 0...3 {
    print("hello")
}

for index in stride(from: 1, through: 5, by: 2) {
    print(index)
}   // through是包括5

let dictionary = ["firstName": "Mango", "lastName": "Fang"]
for (key, value) in dictionary {
    print(key + " " + value)
}
//: Nil Coalescing Operator
var a: String?
var b = "b"
var c = a ?? b  // b
var d = (a != nil) ? a! : b // b  等价于 a ?? b
//: ???
var draw: (CGContext)->() = { _ in () }

//: [Back](Home)



