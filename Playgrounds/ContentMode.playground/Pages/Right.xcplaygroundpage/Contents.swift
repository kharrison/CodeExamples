import UIKit
import PlaygroundSupport
/*:
 ### Right
 Fix the position of the content. Does not scale
 or stretch the content.
 */
let myView = StarView(frame: CGRect(x: 0, y: 0, width:200, height:350))
myView.starImageView.contentMode = .right
myView
PlaygroundPage.current.liveView = myView
//: [Previous](@previous)
//: [Index](contentMode)
//: [Next](@next)
