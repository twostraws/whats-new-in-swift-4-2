/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Enhanced conditional conformances

 Conditional conformances [were introduced in Swift 4.1](https://www.hackingwithswift.com/articles/50/whats-new-in-swift-4-1), allowing types to conform to a protocol only when certain conditions are met.

 For example, if we had a `Purchaseable` protocol:
*/
protocol Purchaseable {
    func buy()
}
/*:
 And a simple type that conforms to that protocol:
*/
struct Book: Purchaseable {
    func buy() {
        print("You bought a book")
    }
}
/*:
 Then we could make `Array` conform to `Purchaseable` if all the elements inside the array were also `Purchasable`:
*/
extension Array: Purchaseable where Element: Purchaseable {
    func buy() {
        for item in self {
            item.buy()
        }
    }
}
/*:
 This worked great at compile time, but there was a problem: if you needed to query a conditional conformance at runtime, your code would crash because it wasn’t supported in Swift 4.1

 Well, in Swift 4.2 that’s now fixed, so if you receive data of one type and want to check if it can be converted to a conditionally conformed protocol, it works great.

 For example:
*/
let items: Any = [Book(), Book(), Book()]

if let books = items as? Purchaseable {
    books.buy()
}
/*:
 In addition, support for automatic synthesis of `Hashable` conformance has improved greatly in Swift 4.2. Several built-in types from the Swift standard library – including optionals, arrays, dictionaries, and ranges – now automatically conform to the `Hashable` protocol when their elements conform to `Hashable`.

 For example:
*/
struct User: Hashable {
    var name: String
    var pets: [String]
}
/*:
 Swift 4.2 can automatically synthesize `Hashable` conformance for that struct, but Swift 4.1 could not.

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
