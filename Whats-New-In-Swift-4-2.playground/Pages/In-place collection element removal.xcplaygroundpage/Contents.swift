/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## In-place collection element removal

 [SE-0197](https://github.com/apple/swift-evolution/blob/master/proposals/0197-remove-where.md) introduces a new `removeAll(where:)` method that performs a high-performance, in-place filter for collections. You give it a closure condition to run, and it will strip out all objects that match the condition.

 For example, if you have a collection of names and want to remove people called “Terry”, you’d use this:
*/
var pythons = ["John", "Michael", "Graham", "Terry", "Eric", "Terry"]
pythons.removeAll { $0.hasPrefix("Terry") }
print(pythons)
/*:
 Now, you might very well think that you could accomplish that by using `filter()` like this:
*/
 pythons = pythons.filter { !$0.hasPrefix("Terry") }
/*:
 However, that doesn’t use memory very efficiently, it specifies what you *don’t* want rather than what you *want*, and more advanced in-place solutions come with a range of complexities that are off-putting to novices. Ben Cohen, the author of SE-0197, gave a talk at [dotSwift 2018](https://www.dotconferences.com/2018/01/ben-cohen-extending-the-standard-library) where he discussed the implementation of this proposal in more detail – if you’re keen to learn why it’s so efficient, you should start there!

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
