/*:
 [< Previous](@previous)           [Home](Introduction)

 ## Boolean toggling

 [SE-0199](https://github.com/apple/swift-evolution/blob/master/proposals/0199-bool-toggle.md) introduces a new `toggle()` method to booleans that flip them between true and false. This caused a lot of discussion in the Swift community, partly because some thought it too trivial for inclusion, but partly also because the Swift Forums discussion [veered out of control at times](http://ericasadun.com/2018/03/09/swift-evolution-and-civility/).

 The entire code to implement proposal is only a handful of lines of Swift:
*/
extension Bool {
    mutating func toggle() {
        self = !self
    }
}
/*:
 However, the end result makes for much more natural Swift code:
*/
var loggedIn = false
loggedIn.toggle()
/*:
 As noted in the proposal, this is particularly useful in more complex data structures: `myVar.prop1.prop2.enabled.toggle()` avoids the potential typing errors that could be caused using manual negation.

 The proposal makes Swift easier and safer to write, and is purely additive, so I think most folks will switch to using it quickly enough.
 
 &nbsp;

 [< Previous](@previous)           [Home](Introduction)
 */
