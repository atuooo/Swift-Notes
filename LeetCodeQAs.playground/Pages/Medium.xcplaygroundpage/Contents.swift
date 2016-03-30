//: [Previous](@previous)

import Foundation

/*:
## Product of Array Except Self
Given an array of n integers where n > 1, nums, return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].

Solve it without division and in O(n).

For example, given [1,2,3,4], return [24,12,8,6].

Follow up:
Could you solve it with constant space complexity? (Note: The output array does not count as extra space for the purpose of space complexity analysis.)
*/
// 重点是不能用除法且复杂度在 O(n)
func productExceptSelf(nums: [Int]) -> [Int] {
    let len = nums.count
    var output = Array(count: len, repeatedValue: 0)
    output[len-1] = nums[len-1]
    
    var i : Int
    for i = len-2; i >= 0; i -= 1 {
        output[i] = nums[i]
        output[i] *= output[i+1]
    }
    
    var tmp = 1, now = 1, inum = 1
    for i = 0; i < len; i += 1 {
        now = tmp
        inum = nums[i]
        if i+1 < len {
            output[i] = (now * output[i+1])
        } else {
            output[i] = now
        }
        now = inum
        tmp *= now
    }
    
    return output
}
