/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Random number generation and shuffling

 [SE-0202](https://github.com/apple/swift-evolution/blob/master/proposals/0202-random-unification.md) introduces a new random API that’s native to Swift. This means you can for the most part stop using `arc4random_uniform()` and GameplayKit to get randomness, and instead rely on a cryptographically secure randomizer that’s baked right into the core of the language.

 You can generate random numbers by calling the `random()` method on whatever numeric type you want, providing the range you want to work with. For example, this generates a random number in the range 1 through 4, inclusive on both sides:
*/
let randomInt = Int.random(in: 1..<5)
/*:
 Similar methods exist for `Float`, `Double`, and other numeric types:
*/
let randomFloat = Float.random(in: 1..<10)
let randomDouble = Double.random(in: 1...100)
/*:
 There’s also one for booleans, generating either true or false randomly:
*/
let randomBool = Bool.random()
/*:
 Checking a random boolean is effectively the same as checking `Int.random(in: 0...1) == 1`, but it expresses your intent more clearly.

 SE-0202 also includes support for shuffling arrays using new `shuffle()` and `shuffled()` methods depending on whether you want in-place shuffling or not. For example:
*/
var albums = ["Red", "1989", "Reputation"]

// shuffle in place
albums.shuffle()

// get a shuffled array back
let shuffled = albums.shuffled()
/*:
 It also adds a new `randomElement()` method to arrays, which returns one random element from the array if it isn’t empty, or nil otherwise:
*/
if let random = albums.randomElement() {
    print("The random album is \(random).")
}
/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
