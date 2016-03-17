//: [Previous](@previous)

import UIKit

//: Q: Why SequenceType but CollectionType doesn't have 'flatMap'

/// Return an Array containing the concatenated results of mapping transform over self.
let nestedArray = [[1], [2,3], [4,5,6]]

let flattenedArray = nestedArray.flatMap { $0 }
flattenedArray // [1, 2, 3, 4, 5, 6]

let multipliedFlattenedArray = nestedArray.flatMap { $0.map { $0 * 2 } }
multipliedFlattenedArray    // [2, 4, 6, 8, 10, 12]

/// flatMap 会帮你去除掉nil
let optionalInts: [Int?] = [1, 2, nil, 4, nil, 5]

let ints = optionalInts.flatMap { $0 }
ints // [1, 2, 4, 5] - this is an [Int]

let arrayOfNumbers = [1, 2, 3, 4]
arrayOfNumbers.forEach{ print($0) }
let arrayOfString = arrayOfNumbers.map { "\($0)" }
arrayOfString

//class ListItem {
//    var icon: UIImage?
//    var title: String = ""
//    var url: NSURL!
//    
//    static func listItemsFromJSONData(jsonData: NSData?) -> [ListItem] {
//        guard let nonNilJsonData = jsonData,
//            let json = try? NSJSONSerialization.JSONObjectWithData(nonNilJsonData, options: []),
//            let jsonItems = json as? Array<NSDictionary>
//            else {
//                // 倘若JSON序列化失败，或者转换类型失败
//                // 返回一个空数组结果
//                return []
//        }
//        
//        var items = [ListItem]()
//        for itemDesc in jsonItems {
//            let item = ListItem()
//            if let icon = itemDesc["icon"] as? String {
//                item.icon = UIImage(named: icon)
//            }
//            if let title = itemDesc["title"] as? String {
//                item.title = title
//            }
//            if let urlString = itemDesc["url"] as? String, let url = NSURL(string: urlString) {
//                item.url = url
//            }
//            items.append(item)
//        }
//        return items
//    }
//}

let testDictionary = [
    "title": "I'm title",
    "url": "http://swift.gg/2015/10/09/thinking-in-swift-2/"
]

print(testDictionary.dynamicType)

class ListDictionary {
    var icon: UIImage?
    var title: String = ""
    var url: NSURL!
    
    static func listItemsFromDictionary(itemDictionary: Dictionary<String, String>?) -> ListDictionary {
            guard let itemDic = itemDictionary
                else {
                    return ListDictionary()
        }
        
        let item = ListDictionary()
        
        itemDic.map { _,_ in
            if let title = itemDic["title"] {
                item.title = title
            }
            if let urlString = itemDic["url"],
               let url = NSURL(string: urlString) {
                    item.url = url
            }
        }
        
        return item
    }
}

print(ListDictionary.listItemsFromDictionary(testDictionary).url)


class ListItem {
    var icon: UIImage?
    var title: String = ""
    var url: NSURL!
    
    static func listItemsFromJSONData(jsonData: NSData?) -> [ListItem] {
        guard let nonNilJsonData = jsonData,
            let json = try? NSJSONSerialization.JSONObjectWithData(nonNilJsonData, options: []),
            let jsonItems = json as? Array<NSDictionary>
            else {
                // 倘若JSON序列化失败，或者转换类型失败
                // 返回一个空数组结果
                return []
        }
        
        return jsonItems.map { (itemDesc: NSDictionary) -> ListItem in
            let item = ListItem()
            if let icon = itemDesc["icon"] as? String {
                item.icon = UIImage(named: icon)
            }
            if let title = itemDesc["title"] as? String {
                item.title = title
            }
            if let urlString = itemDesc["url"] as? String,
                let url = NSURL(string: urlString) {
                    item.url = url
            }
            return item
        }
        
//        return jsonItems.flatMap { (itemDesc: NSDictionary) -> ListItem? in
//            guard let title = itemDesc["title"] as? String,
//                  let urlString = itemDesc["url"] as? String,
//                  let url = NSURL(string: urlString)
//            else { return nil }
//            
//            let li = ListItem()
//            
//            if let icon = itemDesc["icon"] as? String {
//                li.icon = UIImage(named: icon)
//            }
//            li.title = title
//            li.url = url
//            return li
//        }
    }
}

//: [Next](@next)
