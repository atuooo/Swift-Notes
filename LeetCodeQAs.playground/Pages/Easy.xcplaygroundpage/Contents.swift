//: Playground - noun: a place where people can play

import UIKit

/*:
## Nim Game
You are playing the following Nim Game with your friend: There is a heap of stones on the table, each time one of you take turns to remove 1 to 3 stones. The one who removes the last stone will be the winner. You will take the first turn to remove the stones.

Both of you are very clever and have optimal strategies for the game. Write a function to determine whether you can win the game given the number of stones in the heap.

For example, if there are 4 stones in the heap, then you will never win the game: no matter 1, 2, or 3 stones you remove, the last stone will always be removed by your friend.
*/
/// 只要不是4的倍数就能赢，如果换成每次只能抽 1~x 个，那只要不是 (1+x) 的倍数就能赢
func canWinNim(n: Int) -> Bool {
    return (n%4 != 0) ? true: false
}

/*:
## Add Digits
Given a non-negative integer num, repeatedly add all its digits until the result has only one digit.

For example:

Given num = 38, the process is like: 3 + 8 = 11, 1 + 1 = 2. Since 2 has only one digit, return it.

Follow up:
Could you do it without any loop/recursion in O(1) runtime?
*/
// 单纯的算术
func addDigits(num: Int) -> Int {
    if num == 0 {
        return 0
    } else {
        let digit = num % 9
         return (digit != 0) ? digit: 9
    }
}

/*:
## Maximum Depth of Binary Tree
 Given a binary tree, find its maximum depth.
 
 The maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.
 */
// 求二叉树的深度
// Definition for a binary tree node.
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

// 取左右子树的最大值, 然后 +1
func maxDepth(root: TreeNode?) -> Int {
    if let root = root {
        let left = maxDepth(root.left)
        let right = maxDepth(root.right)
        return max(left, right) + 1
    } else {
        return 0
    }
}

/*:
 ## Invert a binary tree
 This problem was inspired by this original [tweet](https://twitter.com/mxcl/status/608682016205344768) by Max Howell: 😳
 
 Google: 90% of our engineers use the software you wrote (Homebrew), but you can’t invert a binary tree on a whiteboard so fuck off.
 */
// 翻转二叉树
func invertTree(root: TreeNode?) -> TreeNode? {
    if let root = root {
        let tree: TreeNode? = TreeNode(root.val)
        tree!.left  = invertTree(root.right)
        tree!.right = invertTree(root.left)
        return tree
    } else {
        return root
    }
}

/*:
 ## Move Zeroes
 Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.
 
 For example, given nums = [0, 1, 0, 3, 12], after calling your function, nums should be [1, 3, 12, 0, 0].
 
 Note:
 You must do this in-place without making a copy of the array.
 Minimize the total number of operations.
 */
// 将数组里面的 0 移到最后面，其余数的位置关系不变
func moveZeroes(inout nums: [Int]) {
    var j = 0
    for i in 0 ..< nums.count {
        if nums[i] != 0 {
            let temp = nums[i]
            nums[i] = nums[j]
            nums[j] = temp
            j += 1
        }
    }
}

/*:
 ## Same Tree
 Given two binary trees, write a function to check if they are equal or not.
 
 Two binary trees are considered equal if they are structurally identical and the nodes have the same value.
 */
func isSameTree(p: TreeNode?, _ q: TreeNode?) -> Bool {
    if p == nil && q == nil {
        return true         // 空树相等
    }
    
    if (p == nil && q != nil) || (p != nil && q == nil) || (p?.val != q?.val) {
        return false        // 一个为空 or 节点值不等 则不相等
    }
    
    // 判断子树是否相等
    return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
}

/*:
 ## Valid Anagram 
 Given two strings s and t, write a function to determine if t is an anagram of s.
 
 For example,
 s = "anagram", t = "nagaram", return true.
 s = "rat", t = "car", return false.
 
 Note:
 You may assume the string contains only lowercase alphabets.
 
 Follow up:
 What if the inputs contain unicode characters? How would you adapt your solution to such case?
 */
// 是不是有点投机取巧？
func isAnagram(s: String, _ t: String) -> Bool {
    let ss = s.characters.sort(>)
    let ts = t.characters.sort(>)
    
    if ss == ts {
        return true
    } else {
        return false
    }
}

isAnagram("ad", "abc!")

/*:
 ## Excel Sheet Column Title
 Given a positive integer, return its corresponding column title as appear in an Excel sheet.
 
 For example:
` 
    1  -> A
    2  -> B
    3  -> C
    ...
    26 -> Z
    27 -> AA
    28 -> AB
`
 */
func convertToTitle(n: Int) -> String {
    var out = ""
    var num = n
    while num > 0 {
        // 使用 String(format: _,_) Leetcode会报错：Current stack trace
        out = "\(UnicodeScalar((num-1) % 26 + 65))" + out
        num = (num - 1) / 26
    }
    
    return out
}

/*:
 ## Excel Sheet Column Number
 Related to question Excel Sheet Column Title
 
 Given a column title as appear in an Excel sheet, return its corresponding column number.
 
 For example:
`
  A -> 1
  B -> 2 
  ...
  Z -> 26 
 AA -> 27
 AB -> 28
`
 */
func titleToNumber(s: String) -> Int {
    var out = 0
    for unicode in s.unicodeScalars {
        out = out * 26 + Int(unicode.value) - 64
    }
    
    return out
}
