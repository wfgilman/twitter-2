//
//  ProfileCell.swift
//  Twitter
//
//  Created by Will Gilman on 4/23/17.
//  Copyright © 2017 Will Gilman. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    var user: User? {
        didSet {
            nameLabel.text = user?.name
            screennameLabel.text = user?.screenname
            followerCountLabel.text = "\((user?.followersCount)!)"
            followingCountLabel.text = "\((user?.followingCount)!)"
            tweetCountLabel.text = "\((user?.tweetCount)!)"
            profileImageView.setImageWith((user?.profileUrl)!)
            UIView.animate(withDuration: 0.15) {
                self.profileImageView.alpha = 1.0
            }
        }
    }
    
    override func awakeFromNib() {
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
