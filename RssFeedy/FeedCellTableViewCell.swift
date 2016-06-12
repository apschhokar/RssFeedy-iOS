//
//  FeedCellTableViewCell.swift
//  RssFeedy
//
//  Created by ajay singh on 6/11/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

import UIKit

class FeedCellTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
