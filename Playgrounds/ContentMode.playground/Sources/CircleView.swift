import UIKit

public class CircleView: UIView {
    
    var lineWidth: CGFloat = 5 {
        didSet { setNeedsDisplay() }
    }
    
    var color: UIColor = .red {
        didSet { setNeedsDisplay() }
    }

    public override func draw(_ rect: CGRect) {
        
        let circleCenter = convert(center, from: superview)
        let circleRadius = min(bounds.size.width,bounds.size.height)/2 * 0.80
        let circlePath = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        circlePath.lineWidth = lineWidth
        color.set()
        circlePath.stroke()
    }
}
