/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Simpler, more secure hashing

 Swift 4.2 implements [SE-0206](https://github.com/apple/swift-evolution/blob/master/proposals/0206-hashable-enhancements.md), which simplifies the way we make custom types conform to the `Hashable` protocol.

 From Swift 4.1 onwards conformance to `Hashable` can be synthesized by the compiler. However, if you want your own hashing implementation – for example, if your type has many properties but you know that one of them was enough to identify it uniquely – you still need to write your own code using whatever algorithm you thought was best.

 Swift 4.2 introduces a new `Hasher` struct that provides a randomly seeded, universal hash function to make this process easier:
*/
struct iPad: Hashable {
    var serialNumber: String
    var capacity: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(serialNumber)
    }
}
/*:
 You can add more properties to your hash by calling `combine()` repeatedly, and the order in which you add properties affects the finished hash value.

 You can also use `Hasher` as a standalone hash generator: just provide it with whatever values you want to hash, then call `finalize()` to generate the final value. For example:
*/
let first = iPad(serialNumber: "12345", capacity: 256)
let second = iPad(serialNumber: "54321", capacity: 512)

var hasher = Hasher()
hasher.combine(first)
hasher.combine(second)
let hash = hasher.finalize()
/*:
 `Hasher` uses a random seed every time it hashes an object, which means the hash value for any object is effectively guaranteed to be different between runs of your app.

 This in turn means that elements you add to a set or a dictionary are highly likely to have a different order each time you run your app.

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
