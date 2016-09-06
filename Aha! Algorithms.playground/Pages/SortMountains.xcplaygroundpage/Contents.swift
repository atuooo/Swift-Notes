import Foundation

var test = [12, 2, 56, 23, 45, 7, 3, 19, 11]

/*: 
 Bubble Sort: [👉](https://en.wikipedia.org/wiki/Bubble_sort)
 
 ![](bubble-sort_295a6a.gif)
 */

func bubbleSort(input: [Int]) -> [Int] {
//    return input.sorted(by: >)    // which algorithm ? [👉](https://github.com/apple/swift/tree/master/docs) [Compare](http://stackoverflow.com/questions/24101718/swift-performance-sorting-arrays?rq=1)
    
    var output = input
    
    for i in 0 ..< output.count - 1 {
        for j in 0 ..< output.count - i - 1 {
            if output[j] < output[j+1] {
                swap(&output[j], &output[j+1])
            }
        }
    }
    
//// reverse bubble ? or not bubble
//    for i in 0 ..< output.count - 1 {
//        for j in i+1 ..< output.count {
//            if output[i] < output[j] {
//                let tmp = output[j]
//                output[j] = output[i]
//                output[i] = tmp
//                
//                print(i, output)
//            }
//        }
//    }
    
    return output
}

bubbleSort(input: test)

/*:
 Quick Sort: [👉](https://en.wikipedia.org/wiki/Quicksort)
 
 ![](Sorting_quicksort_anim.gif)
 
 */

func quickSort(input: [Int]) -> [Int] {
    var output = input
    
    func quicksort(left: Int, right: Int) {
        
        if left > right {
            return
        }
        
        var tmp = output[left], i = left, j = right
        
        while i ^ j == 1 {
            
            while output[j] >= tmp && i < j {
                j -= 1
            }
            
            while output[i] <= tmp && i < j {
                i += 1
            }
            
            if i < j {
                swap(&output[i], &output[j])
            }
        }
        
        output[left] = output[i]
        output[i] = tmp
        
        quicksort(left: left, right: i - 1)
        quicksort(left: i + 1, right: right)
    }
    
    quicksort(left: 0, right: output.count - 1)
    return output
}

quickSort(input: test)

/*:
 extension: Insertion Sort: [👉](https://en.wikipedia.org/wiki/Insertion_sort)
 
 ![](Insertion_sort.gif)
 
 */

func insertionSort<T>(input: [T], _ areInIncreasingOrder: @noescape (T, T) -> Bool) -> [T] {
    var output = input
    
    for i in 1 ..< output.count {
        
        var j = i
        let tmp = output[j]
        while  j > 0 && areInIncreasingOrder(tmp, output[j-1]) {
            output[j] = output[j-1]
            j -= 1
        }
        
        output[j] = tmp
    }
    
    return output
}

insertionSort(input: test, <)


