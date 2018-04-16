import UIKit

public class StarView: UIView {

    public let starImageView: UIImageView
    
    public override init(frame: CGRect) {
        let starImage = UIImage(named: "star100")
        starImageView = UIImageView(image: starImage)

        super.init(frame: frame)
        addSubview(starImageView)
        backgroundColor = .green
        starImageView.frame = bounds
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}

