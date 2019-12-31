//  GridView.swift
//  Created by Keith Harrison https://useyourloaf.com
//  Copyright (c) 2017 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  3. Neither the name of the copyright holder nor the names of its
//  contributors may be used to endorse or promote products derived from
//  this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

import UIKit

/// `GridView` is a custom `UIView` subclass that draws
/// a grid of evenly spaced lines in the bounds of the view.
/// Attention: You probably want to set the `contentMode` to `.redraw`.

@IBDesignable
public class GridView: UIView {
    /// The number of horizontal rows - default is 1.
    @IBInspectable public var rowCount: Int = 1 { didSet { setNeedsDisplay() } }

    /// The number of vertical columns - default is 1.
    @IBInspectable public var columnCount: Int = 1 { didSet { setNeedsDisplay() } }

    /// The grid line color - default is red.
    @IBInspectable public var lineColor: UIColor = .red { didSet { setNeedsDisplay() } }

    /// The grid line width - default is 1 point.
    @IBInspectable public var lineWidth: CGFloat = 1.0 { didSet { setNeedsDisplay() } }

    public override func draw(_ rect: CGRect) {
        lineColor.set()
        rowPath?.stroke()
        columnPath?.stroke()
    }

    private var rowPath: UIBezierPath? {
        guard rowCount > 0 else {
            return nil
        }

        let rowPath = UIBezierPath()
        rowPath.lineWidth = lineWidth
        let rowHeight = bounds.size.height / CGFloat(rowCount + 1)
        for row in 1...rowCount {
            let y = rowHeight * CGFloat(row)
            let startPoint = CGPoint(x: bounds.minX, y: y)
            let endPoint = CGPoint(x: bounds.maxX, y: y)
            rowPath.move(to: startPoint)
            rowPath.addLine(to: endPoint)
        }
        return rowPath
    }

    private var columnPath: UIBezierPath? {
        guard columnCount > 0 else {
            return nil
        }

        let columnPath = UIBezierPath()
        columnPath.lineWidth = lineWidth
        let columnWidth = bounds.size.width / CGFloat(columnCount + 1)
        for row in 1...columnCount {
            let x = columnWidth * CGFloat(row)
            let startPoint = CGPoint(x: x, y: bounds.minY)
            let endPoint = CGPoint(x: x, y: bounds.maxY)
            columnPath.move(to: startPoint)
            columnPath.addLine(to: endPoint)
        }
        return columnPath
    }
}
