/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Checking sequence elements match a condition

 [SE-0207](https://github.com/apple/swift-evolution/blob/master/proposals/0207-containsOnly.md) provides a new `allSatisfy()` method that checks whether all items in a sequence pass a condition. 

 For example, if we had an array of exam results like this:
*/
let scores = [85, 88, 95, 92]
/*:
 We could decide whether a student passed their course by checking whether all their exam results were 85 or higher:
*/
let passed = scores.allSatisfy { $0 >= 85 }
/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
