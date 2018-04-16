import UIKit
import PlaygroundSupport
/*:
 ### Scale Aspect Fill
 `ScaleAspectFill` scales the content to totally fill the view maintaining the aspect ratio. This can result in the content being larger than the bounds of the view.

 */
let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
containerView.backgroundColor = .red

let myView = StarView(frame: CGRect(x: 0, y: 0, width:200, height:350))
containerView.addSubview(myView)
myView.center = CGPoint(x: 200, y: 200)

myView.starImageView.contentMode = .scaleAspectFill
/*:
 #### clipToBounds
 You will most likely want to have the superview set to clip subviews
 to bounds to prevent the scaled view from being visible outside the
 super view.
 
 Try changing the following setting to see the difference.
 */
myView.clipsToBounds = true

containerView
PlaygroundPage.current.liveView = containerView
//: [Previous](@previous)
//: [Index](contentMode)
//: [Next](@next)
