import UIKit
import PlaygroundSupport

let viewController = MarginViewController()
viewController.view.backgroundColor = .white
viewController.view.frame = CGRect(x: 0, y: 0, width: 320, height: 640)
PlaygroundPage.current.liveView = viewController.view

viewController.redView.preservesSuperviewLayoutMargins = true

viewController.stackView.preservesSuperviewLayoutMargins = true
viewController.stackView.isLayoutMarginsRelativeArrangement = true

viewController.stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
