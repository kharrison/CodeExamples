//
//  ScrollingStackViewController.swift
//  Stacks
//
//  Created by Keith Harrison on 09/03/2016.
//  Copyright © 2016 Keith Harrison. All rights reserved.
//

import UIKit

class ScrollingStackViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBAction func singleTap(sender: UITapGestureRecognizer) {
        let heartImage = UIImage(named: "Heart")
        let heartImageView = UIImageView(image: heartImage)
        self.stackView.addArrangedSubview(heartImageView)
        self.scrollToEnd(heartImageView)
    }
    
    @IBAction func twoFingerTap(sender: UITapGestureRecognizer) {
        let starImage = UIImage(named: "Star")
        let starImageView = UIImageView(image: starImage)
        self.stackView.addArrangedSubview(starImageView)
        self.scrollToEnd(starImageView)
    }
    
    @IBAction func threeFingerTap(sender: UITapGestureRecognizer) {
        let views = stackView.arrangedSubviews
        for entry in views {
            stackView.removeArrangedSubview(entry)
            entry.removeFromSuperview()
        }
    }
    
    private func scrollToEnd(addedView: UIView) {
        let contentViewHeight = scrollView.contentSize.height + addedView.bounds.height + stackView.spacing
        let offsetY = contentViewHeight - scrollView.bounds.height
        if (offsetY > 0) {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: offsetY), animated: true)
        }
    }
}
