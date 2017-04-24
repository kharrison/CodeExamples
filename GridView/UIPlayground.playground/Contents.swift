//: PlaygroundUI
import UIKit
import GridViewUI
import PlaygroundSupport

//: Demo using the grid view
let grid = GridView()
grid.backgroundColor = .lightGray
grid.rowCount = 3
grid.columnCount = 3
grid.lineColor = .blue
grid.lineWidth = 5

//: Show in live view
grid.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
PlaygroundPage.current.liveView = grid