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


