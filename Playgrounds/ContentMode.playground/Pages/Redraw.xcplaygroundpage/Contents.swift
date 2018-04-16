import UIKit
import PlaygroundSupport
/*:
 ### Redraw
 
 Use this mode when you have a custom view that implements drawRect.
 
 When the bounds of the view change the view will be redrawn by
 calling drawRect.
 */
let myView = CircleView(frame: CGRect(x: 0, y: 0, width:200, height:350))
myView.backgroundColor = .white
myView.contentMode = .redraw
myView
PlaygroundPage.current.liveView = myView
//: [Previous](@previous)
//: [Index](contentMode)
//: [Next](@next)
