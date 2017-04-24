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

    var user: User? {
        didSet {
            if user?.profileBackgroundUrl != nil {
                profileBackgroundImageView.setImageWith((user?.profileBackgroundUrl)!)
            } else {
                profileBackgroundImageView.image = UIImage(named: "defaultbg")
            }
            UIView.animate(withDuration: 0.15) {
                self.profileBackgroundImageView.alpha = 1.0
            }
        }
    }

}
