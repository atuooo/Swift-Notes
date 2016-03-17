//: ## Availability Check
//:  /ə,velə'bɪləti/

import Foundation

//: Before Swift 2
if NSClassFromString("NSURLQueryItem") != nil {
    // iOS 8 or up
} else{
    // Earlier iOS versions
}

//: In Swift 2
if #available(iOS 8, OSX 10.10, *) { // * is required and specifies
    // iOS 8 or OSX 10.10 up
    let queryItem = NSURLQueryItem()
} else {
    // Earlier iOS and OSX versions
}

func InSwift2() {
    guard #available(iOS 8.4, OSX 10.10, *) else {
        print("what to do if it doesn't meet the minimum OS requirement")
        return
    }
}

@available(iOS 9, *)
class SuperFancy {
    // implementation
}

//: [Back](Home)
