import UIKit

public class CircleView: UIView {
    
    var lineWidth: CGFloat = 5 {
        didSet { setNeedsDisplay() }
    }
    
    var color: UIColor = .redColor() {
        didSet { setNeedsDisplay() }
    }
    
    public override func drawRect(rect: CGRect) {
        
        let circleCenter = convertPoint(center, fromView: superview)
        let circleRadius = min(bounds.size.width,bounds.size.height)/2 * 0.80
        let circlePath = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        circlePath.lineWidth = lineWidth
        color.set()
        circlePath.stroke()
    }
}
