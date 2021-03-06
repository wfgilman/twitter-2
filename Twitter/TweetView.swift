//
//  TweetView.swift
//  Twitter
//
//  Created by Will Gilman on 4/13/17.
//  Copyright © 2017 Will Gilman. All rights reserved.
//

import UIKit

class TweetView: UIView {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.user?.name
            screennameLabel.text = "@\((tweet.user?.screenname)!)"
            tweetTextLabel.text = tweet.text
            userImageView.setImageWith((tweet.user?.profileUrl)!)
            UIView.animate(withDuration: 0.15, animations: { () -> Void in
                self.userImageView.alpha = 1.0
            })
            createdAtLabel.text = tweet.timestampDateTime!
            retweetsLabel.text = "\(tweet.retweetCount)"
            favoritesLabel.text = "\(tweet.favoritesCount)"
        }
    }
    
    override func awakeFromNib() {
        userImageView.layer.cornerRadius = 3
        userImageView.clipsToBounds = true
    }

}
