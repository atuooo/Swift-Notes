//: [Previous](@previous)

import Foundation

// http://swifter.tips/regex/

struct RegexHelper {
    let regex: NSRegularExpression?
    
    init(_ pattern: String) {
        regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    func match(input: String) -> Bool {
        if let matches = regex?.matches(in: input,
            options: .reportProgress,
            range: NSMakeRange(0, input.characters.count)) {
                return matches.count > 0
        } else {
            return false
        }
    }
}

let mailPattern =
"^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
let matcher = RegexHelper(mailPattern)
let maybeMailAddress = "onev@onevcat.com"

if matcher.match(input: maybeMailAddress) {
    print("有效的邮箱地址")
}

// http://blog.csdn.net/xn4545945/article/details/37684127

func loadHTMLWithWord(word: String) {
    var urlString = "http://dict.cn/\(word)"
    //中文转义 
    
    urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    
    let url = NSURL(string: urlString)
    
    let request = NSURLRequest(url: url! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5.0)
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
        //得到的data数据转换为字符串
        let html = NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue)
        let result: NSString = findAnswerInHTML(html: html!)
        print(result)
    }
    task.resume()
}

func findAnswerInHTML(html: NSString) -> NSString {
    //将需要取出的用(.*?)代替. 大空格换行等用.*?代替,表示忽略.
    let pattern = "<ul class=\"dict-basic-ul\">.*?<li><span>(.*?)</span><strong>(.*?)</strong></li>"
    
    //实例化正则表达式，需要指定两个选项
    //NSRegularExpressionCaseInsensitive  忽略大小写
    //NSRegularExpressionDotMatchesLineSeparators 让.能够匹配换行
    let regex = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive, .dotMatchesLineSeparators])
    
    //匹配出结果集
    let checkResult = regex.firstMatch(in: html as String, options: .reportCompletion, range: NSMakeRange(0, html.length))
    
    // 取出找到的内容. 数字分别对应第几个带括号(.*?), 取0时输出匹配到的整句
    let result = html.substring(with: (checkResult?.rangeAt(2))!)
    
    return result as NSString
}

//
var telefone = "+42 43 23123-2221"
let range = telefone.range(of: "\\d{4,5}\\-?\\d{4}", options: .regularExpression, range: nil, locale: nil)
//let range = telefone.rangeOfString("\\d{4,5}\\-?\\d{4}", options:.RegularExpressionSearch)
print("range \(range)")

//: [Next](@next)
