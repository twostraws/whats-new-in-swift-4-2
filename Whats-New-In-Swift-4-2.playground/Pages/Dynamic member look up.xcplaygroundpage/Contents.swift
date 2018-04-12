/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

## Dynamic member look up

 [SE-0195](https://github.com/apple/swift-evolution/blob/master/proposals/0195-dynamic-member-lookup.md) introduces a way to bring Swift closer to scripting languages such as Python, but in a type-safe way – you don’t lose any of Swift’s safety, but you do gain the ability to write the kind of code you’re more likely to see in PHP and Python.

 At the core of this feature is a new attribute called `@dynamicMemberLookup`, which instructs Swift to call a subscript method when accessing properties. This subscript method, `subscript(dynamicMember:)`, is *required*: you’ll get passed the string name of the property that was requested, and can return any value you like.

 Let’s look at a trivial example so you can understand the basics. We could create a `Person` struct that reads its values from a dictionary like this:
*/
@dynamicMemberLookup
struct Person {
    subscript(dynamicMember member: String) -> String {
        let properties = ["name": "Taylor Swift", "city": "Nashville"]
        return properties[member, default: ""]
    }
}
/*:
 The `@dynamicMemberLookup` attribute requires the type to implement a `subscript(dynamicMember:)` method to handle the actual work of dynamic member lookup. As you can see, I’ve written one that accepts the member name as string and returns a string, and internally it just looks up the member name in a dictionary and returns its value.

 That struct allows us to write code like this:
*/
let person = Person()
print(person.name)
print(person.city)
print(person.favoriteIceCream)
/*:
 That will compile cleanly and run, even though `name`, `city`, and `favoriteIceCream` do not exist as properties on the `Person` type. Instead, they are all looked up at runtime: that code will print “Taylor Swift” and “Nashville” for the first two calls to `print()`, then an empty string for the final one because our dictionary doesn’t store anything for `favoriteIceCream`.

 My `subscript(dynamicMember:)` method *must* return a string, which is where Swift’s type safety comes in: even though you’re dealing with dynamic data, Swift will still ensure you get back what you expected. And if you want multiple different types, just implement different `subscript(dynamicMember:)` methods, like this:
*/
@dynamicMemberLookup
struct Employee {
    subscript(dynamicMember member: String) -> String {
        let properties = ["name": "Taylor Swift", "city": "Nashville"]
        return properties[member, default: ""]
    }

    subscript(dynamicMember member: String) -> Int {
        let properties = ["age": 26, "height": 178]
        return properties[member, default: 0]
    }
}
/*:
 Now that any property can be accessed in more than one way, Swift requires you to be clear which one should be run. That might be implicit, for example if you send the return value into a function that accepts only strings, or it might be explicit, like this:
*/
 let employee = Employee()
 let age: Int = employee.age
/*:
 Either way, Swift must know for sure which subscript will be called.

 You can even overload `subscript` to return closures:
*/
@dynamicMemberLookup
struct User {
    subscript(dynamicMember member: String) -> (_ input: String) -> Void {
        return {
            print("Hello! I live at the address \($0).")
        }
    }
}

let user = User()
user.printAddress("555 Taylor Swift Avenue")
/*:
When that’s run, `user.printAddress` returns a closure that prints out a string, and the `("555 Taylor Swift Avenue")` part immediately calls it with that input.

If you use dynamic member subscripting in a type that has also some regular properties and methods, those properties and methods will always be used in place of the dynamic member. For example, we could define a `Singer` struct with a built-in `name` property alongside a dynamic member subscript:
*/
struct Singer {
    public var name = "Justin Bieber"

    subscript(dynamicMember member: String) -> String {
        return "Taylor Swift"
    }
}

let singer = Singer()
print(singer.name)
/*:
 That code will print “Justin Bieber”, because the `name` property will be used rather than the dynamic member subscript.

 `@dynamicMemberLookup` plays a full part in Swift’s type system, which means you can assign them to protocols, structs, enums, and classes – even classes that are marked `@objc`.

 In practice, this means two things. First, you can create a class using `@dynamicMemberLookup`, and any classes that inherit from it are also automatically `@dynamicMemberLookup`. So, this will print “I’m a sandwich” because `HotDog` inherits from `Sandwich`:
*/
@dynamicMemberLookup
class Sandwich {
    subscript(dynamicMember member: String) -> String {
        return "I'm a sandwich!"
    }
}

class HotDog: Sandwich { }

let chiliDog = HotDog()
print(chiliDog.description)
/*:
 - note: If you don’t think hot dogs are sandwiches, why not [follow me on Twitter](https://twitter.com/twostraws) so you can tell me how wrong I am?

 Second, you can retroactively make other types use `@dynamicMemberLookup` by defining it on a protocol, adding a default implementation of `subscript(dynamicMember:)` using a protocol extension, then making other types conform to your protocol however you want.

 For example, this creates a new `Subscripting` protocol, provides a default `subscript(dynamicMember:)` implementation that returns a message, then extends Swift’s `String` to use that protocol:
*/
@dynamicMemberLookup
protocol Subscripting { }

extension Subscripting {
    subscript(dynamicMember member: String) -> String {
        return "This is coming from the subscript"
    }
}

extension String: Subscripting { }
let str = "Hello, Swift"
print(str.username)
/*:
In his Swift Evolution proposal, Chris Lattner also gives an example `JSON` enum that uses dynamic member lookup to create more natural syntax for navigating through JSON:
*/
@dynamicMemberLookup
enum JSON {
    case intValue(Int)
    case stringValue(String)
    case arrayValue(Array<JSON>)
    case dictionaryValue(Dictionary<String, JSON>)

    var stringValue: String? {
        if case .stringValue(let str) = self {
            return str
        }
        return nil
    }

    subscript(index: Int) -> JSON? {
        if case .arrayValue(let arr) = self {
            return index < arr.count ? arr[index] : nil
        }
        return nil
    }

    subscript(key: String) -> JSON? {
        if case .dictionaryValue(let dict) = self {
            return dict[key]
        }
        return nil
    }

    subscript(dynamicMember member: String) -> JSON? {
        if case .dictionaryValue(let dict) = self {
            return dict[member]
        }
        return nil
    }
}
/*:
 Without dynamic member look up you would need to navigate an instance of that `JSON` enum like this:
*/
 let json = JSON.stringValue("Example")
 json[0]?["name"]?["first"]?.stringValue
/*:
 But *with* dynamic member look up you can use this instead:
*/
 json[0]?.name?.first?.stringValue
/*:
 I think this example is particularly important because it gets to the nub of what `@dynamicMemberLookup` does: it’s syntactic sugar that turns a custom subscript into simple dot syntax.

 - note: Using dynamic member lookup means that code completion loses much if not all of its usefulness, because there’s nothing to complete. This isn’t too much of a surprise, though, and it’s something that Python IDEs have had to deal with for some time. Chris Lattner (the author of SE-0195) discussed future possibilities for code completion in the proposal itself – it’s [worth reading](https://github.com/apple/swift-evolution/blob/master/proposals/0195-dynamic-member-lookup.md#future-directions-python-code-completion).

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
