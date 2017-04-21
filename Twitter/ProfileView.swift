//
//  ProfileView.swift
//  Twitter
//
//  Created by Will Gilman on 4/19/17.
//  Copyright © 2017 Will Gilman. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var profileBackgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    var user: User? {
        didSet {
            nameLabel.text = user?.name
            screennameLabel.text = user?.screenname
            followerCountLabel.text = "\((user?.followersCount)!)"
            followerCountLabel.text = "\((user?.followingCount)!)"
            if user?.profileBackgroundUrl != nil {
                profileBackgroundImageView.setImageWith((user?.profileBackgroundUrl)!)
            } else {
                profileBackgroundImageView.image = UIImage(named: "defaultBG")
            }
            profileImageView.setImageWith((user?.profileUrl)!)
            UIView.animate(withDuration: 0.15) { 
                self.profileImageView.alpha = 1.0
                self.profileBackgroundImageView.alpha = 1.0
            }
        }
    }

    override func awakeFromNib() {
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
    }

}
