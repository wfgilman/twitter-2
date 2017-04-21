//
//  MenuCell.swift
//  Twitter
//
//  Created by Will Gilman on 4/20/17.
//  Copyright © 2017 Will Gilman. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    
    @IBOutlet weak var menuLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = twitterColor
        menuLabel.textColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
