//
//  UYLBasicStaticTableViewCell.swift
//  StaticTable
//
//  Created by Keith Harrison on 21/04/2016.
//  Copyright © 2016 Keith Harrison. All rights reserved.
//

import UIKit

class UYLBasicStaticTableViewCell: UITableViewCell {

    @IBOutlet weak var titleText: UILabel!
}

extension UYLBasicStaticTableViewCell: UYLPreferredFont {
    func contentSizeChanged() {
        titleText.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
    }
}
