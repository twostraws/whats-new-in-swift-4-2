/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Warning and error diagnostic directives

 [SE-0196](https://github.com/apple/swift-evolution/blob/master/proposals/0196-diagnostic-directives.md) introduces new compiler directives that help us mark issues in our code. These will be familiar to any developers who had used Objective-C previously, but as of Swift 4.2 we can enjoy them in Swift too.

 The two new directives are `#warning` and `#error`: the former will force Xcode to issue a warning when building your code, and the latter will issue a compile error so your code won’t build at all. Both of these are useful for different reasons:

 * `#warning` is mainly useful as a reminder to yourself or others that some work is incomplete. Xcode templates often use `#warning` to mark method stubs that you should replace with your own code.
 * `#error` is mainly useful if you ship a library that requires other developers to provide some data. For example, an authentication key for a web API – you want users to include their own key, so using `#error` will force them to change that code before continuing.

 Both of these work in the same way: `#warning("Some message")` and `#error("Some message")`. For example:
*/
func encrypt(_ string: String, with password: String) -> String {
    #warning("This is terrible method of encryption")
    return password + String(string.reversed()) + password
}

struct Configuration {
    var apiKey: String {
        #error("Please enter your API key below then delete this line.")
        return "Enter your key here"
    }
}
/*:
 Both `#warning` and `#error` work alongside the existing `#if` compiler directive, and will only be triggered if the condition being evaluated is true. For example:
*/
 #if os(macOS)
 #error("MyLibrary is not supported on macOS.")
 #endif
/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
