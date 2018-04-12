/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Derived collections of enum cases

 [SE-0194](https://github.com/apple/swift-evolution/blob/master/proposals/0194-derived-collection-of-enum-cases.md) introduces a  new `CaseIterable` protocol that automatically generates an array property of all cases in an enum.

 Prior to Swift 4.2 this either took hacks, hand-coding, or Sourcery code generation to accomplish, but now all you need to do is make your enum conform to the `CaseIterable` protocol. At compile time, Swift will automatically generate an `allCases` property that is an array of all your enum’s cases, in the order you defined them.

 For example, this creates an enum of pasta shapes and asks Swift to automatically generate an `allCases` array for it:
*/
enum Pasta: CaseIterable {
    case cannelloni, fusilli, linguine, tagliatelle
}
/*:
 You can then go ahead and use that property as a regular array – it will be a `[Pasta]` given the code above, so we could print it like this:
*/
for shape in Pasta.allCases {
    print("I like eating \(shape).")
}
/*:
 This automatic synthesis of `allCases` will only take place for enums that do not use associated values. Adding those automatically wouldn’t make sense, however if you want you can add it yourself:
*/
enum Car: CaseIterable {
    static var allCases: [Car] {
        return [.ford, .toyota, .jaguar, .bmw, .porsche(convertible: false), .porsche(convertible: true)]
    }

    case ford, toyota, jaguar, bmw
    case porsche(convertible: Bool)
}
/*:
 At this time, Swift is unable to synthesize the `allCases` property if any of your enum cases are marked unavailable. So, if you need `allCases` then you’ll need to add it yourself, like this:
*/
enum Direction: CaseIterable {
    static var allCases: [Direction] {
        return [.north, .south, .east, .west]
    }

    case north, south, east, west

    @available(*, unavailable)
    case all
}
/*:
 - important: You need to add `CaseIterable` to the original declaration of your enum rather than an extension in order for the `allCases` array to be synthesized. This means you can’t use extensions to retroactively make existing enums conform to the protocol.

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
