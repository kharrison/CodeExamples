import UIKit
import XCPlayground
/*:
 ### Scale Aspect Fit
 
  `ScaleAspectFit` scales the content to fit the view but maintains the aspect ratio. Any part of the view bounds that is not filled with content is transparent.
 */
let myView = StarView(frame: CGRect(x: 0, y: 0, width:200, height:350))
myView.starImageView.contentMode = .ScaleAspectFit
myView
XCPlaygroundPage.currentPage.liveView = myView
//: [Previous](@previous)
//: [Index](contentMode)
//: [Next](@next)
